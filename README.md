# nim_shellloader

nim编写的shell_loader

详见以下:
details:
# usage

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
