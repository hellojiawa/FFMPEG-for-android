### 编译环境
windows 7
mingw 6.3.0
ndk r15c
ffmpeg 3.4.1


### 编译前的配置
下载ndk和ffmpeg3.4.1的源码，修改ffmpeg源码目录中的configure
```
SLIBNAME_WITH_MAJOR='$(SLIBNAME).$(LIBMAJOR)'
LIB_INSTALL_EXTRA_CMD='$$(RANLIB) "$(LIBDIR)/$(LIBNAME)"'
SLIB_INSTALL_NAME='$(SLIBNAME_WITH_VERSION)'
SLIB_INSTALL_LINKS='$(SLIBNAME_WITH_MAJOR) $(SLIBNAME)'
```
替换成
```
SLIBNAME_WITH_MAJOR='$(SLIBPREF)$(FULLNAME)-$(LIBMAJOR)$(SLIBSUF)'
LIB_INSTALL_EXTRA_CMD='$$(RANLIB)"$(LIBDIR)/$(LIBNAME)"'
SLIB_INSTALL_NAME='$(SLIBNAME_WITH_MAJOR)'
SLIB_INSTALL_LINKS='$(SLIBNAME)'
```


### 开始编译
把项目下载下来，根目录已经有3个编辑好的.sh脚本文件。运行脚本文件即可开始编译。


### 我遇到的两个问题
##### 问题一
```
arm-linux-androideabi-gcc.exe is unable to create an executable file
```
修改过ndk版本，修改过缩短ndk的路径，仔细对比过arm-linux-androideabi.exe确实存在没有错误，还是报错。
最后找到mingw的安装目录MinGW/msys/1.0，打开mysy.bat，之后再cd到ffmpeg根目录运行脚本文件后解决。

##### 问题二
编译x86架构的时候没有报错，但是编译arm64的时候报错如下：
```
libavcodec/aaccoder.c:803:25: error: expected identifier or '(' before numeric constant
                     int B0 = 0, B1 = 0;
                         ^
libavcodec/aaccoder.c:865:28: error: lvalue required as left operand of assignment
                         B0 += b1+b2;
```
百度之后解决如下：
1. 将libavcodec/aaccoder.c文件B0变量替换成b0
2. 将libavcodec/hevc_mvs.c文件的变量B0改成b0，xB0改成xb0，yB0改成yb0
3. 解决：将libavcodec/opus_pvq.c文件的变量B0改成b0