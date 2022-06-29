
# 记录修复realsense-viewer打开错误librealsense2.so.2.50: undefined symbol: libusb_get_port_numbers

记录修复realsense-viewer打开错误librealsense2.so.2.50: undefined symbol: libusb_get_port_numbers

## ERROR发生
某台安装过Kinect SDK的上位机，做过一些其他环境更改后，某天打开realsense-viewer出现错误：

`realsense-viewer: symbol lookup error: /usr/lib/x86_64-linux-gnu/librealsense2.so.2.50: undefined symbol: libusb_get_port_numbers`

## 错误解析

报错显示：变量查找错误，某个动态库未定义变量。

> Linux下的.so文件是基于Linux下的动态链接库，其功能和作用类似与windows下.dll文件，相关的.a文件是静态链接库。

查看程序运行所需要的共享库文件。
`ldd /usr/lib/x86_64-linux-gnu/librealsense2.so.2.50`

因为报错提示：`libusb_get_port_numbers`，所以先检查libusb。

`ldd /usr/lib/x86_64-linux-gnu/librealsense2.so.2.50|grep libusb`
`libusb-1.0.so.0 => /usr/local/lib/libusb-1.0.so.0 (0x00007facc1791000)`

因为这个问题昨天解决后，今天又重现，可以看到这个.so文件是今天早上开机重新生成的。可以判断有脚本开机时重新生成了.so文件，这里怀疑是rules.d目录下的usb规则。
`$ ll /usr/local/lib/libusb-1.0.so.0`
`lrwxrwxrwx 1 root root 19 6月  29 09:04 /usr/local/lib/libusb-1.0.so.0 -> libusb-1.0.so.0.1.0*`

查看.so文件内容
`$ nm -D /usr/local/lib/libusb-1.0.so.0 |grep port`
没有返回，所以此动态库没有libusb_get_port_numbers方法。该动态库是错误的。

查一下libusb包的信息。
`dpkg -l |grep libusb`
`ii  libusb-1.0-0:amd64                                2:1.0.21-2                                      amd64        userspace USB programming library`
与官方web版本(Ubuntu 18.04 libusb 2:1.0.21-2 )对比一致，排除了安装异常版本的可能。

找一下系统的`libusb-1.0.so`
`locate libusb-1.0.so`

```
$ locate libusb-1.0.so
/home/sy/anaconda3/envs/py37/lib/python3.7/site-packages/libusb/_platform/_linux/x64/libusb-1.0.so
/home/sy/software/OpenNI_2.3.0.81/sdk/thirdpart/libusb-1.0.9/libusb/.libs/libusb-1.0.so
/home/sy/software/OpenNI_2.3.0.81/sdk/thirdpart/libusb-1.0.9/libusb/.libs/libusb-1.0.so.0
/home/sy/software/OpenNI_2.3.0.81/sdk/thirdpart/libusb-1.0.9/libusb/.libs/libusb-1.0.so.0.1.0
/lib/x86_64-linux-gnu/libusb-1.0.so
/lib/x86_64-linux-gnu/libusb-1.0.so.0
/lib/x86_64-linux-gnu/libusb-1.0.so.0.1.0
/lib/x86_64-linux-gnu/libusb-1.0.so.0.bak
/usr/local/lib/libusb-1.0.so
/usr/local/lib/libusb-1.0.so.0
/usr/local/lib/libusb-1.0.so.0.1.0
/usr/local/lib/libusb-1.0.so.0.bak
```

发现/lib/x86...目录下还有一个.so文件，与另一台正常的上位机对比后，发现是使用这个动态库。

```
ll /lib/x86_64-linux-gnu/libusb-1.0*
-rw-r--r-- 1 root root 437102 3月  11 09:50 /lib/x86_64-linux-gnu/libusb-1.0.a
-rwxr-xr-x 1 root root    951 3月  11 09:50 /lib/x86_64-linux-gnu/libusb-1.0.la*
-rwxr-xr-x 1 root root 256096 3月  11 09:50 /lib/x86_64-linux-gnu/libusb-1.0.so*
lrwxrwxrwx 1 root root     19 6月  25  2017 /lib/x86_64-linux-gnu/libusb-1.0.so.0 -> libusb-1.0.so.0.1.0
-rw-r--r-- 1 root root  97080 6月  25  2017 /lib/x86_64-linux-gnu/libusb-1.0.so.0.1.0
lrwxrwxrwx 1 root root     19 3月  10 14:40 /lib/x86_64-linux-gnu/libusb-1.0.so.0.bak -> libusb-1.0.so.0.1.0
```

` /lib/x86_64-linux-gnu/libusb-1.0.so.0.1.0` 这个大小与正常上位机使用的一致。

查看函数。
`$ nm -D /lib/x86_64-linux-gnu/libusb-1.0.so.0.1.0|grep port`

```
0000000000004040 T libusb_get_port_number
0000000000004820 T libusb_get_port_numbers
00000000000048c0 T libusb_get_port_path
```
这个动态库有需要的函数。

现在怀疑是realsense-viewer用错了动态库文件。

## 尝试解决

Linux系统使用LD_LIBRARY_PATH指定查找共享库路径（除了默认路径（./lib和./usr/lib）之外的其他路径）。

尝试修改临时环境变量，使程序优先在/lib/x86_64-linux-gnu路径下查找动态库文件。

`export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH`

再次检查realsense-viewer使用的.so文件。

```
$ ldd /usr/bin/realsense-viewer |grep usb
        libusb-1.0.so.0 => /lib/x86_64-linux-gnu/libusb-1.0.so.0 (0x00007f30cdcb2000)
```
此时引用正确。
尝试启动。

`$ realsense-viewer`

没有报错

这里修改环境变量只是暂时的，而且没有考虑对其他程序的影响。
~~可以先加到bashrc里，再观察一段时间。~~

另一种解决办法（最终使用）：

手动创建/usr/local/lib/libusb-1.0.so.0，使其指向/lib/x86_64-linux-gnu/libusb-1.0.so.0
或直接删除/usr/local/lib/libusb-1.0.so.0，realsense-viewer自动指向/lib/x86_64-linux-gnu/libusb-1.0.so.0

## 继续探索

查一下`/usr/local/lib/libusb`的来源，以及为什么昨天`apt --reinstall` 后解决了，今天开机又复现，重新生成了。

重新生成的软连接
`lrwxrwxrwx 1 root root     19 6月  29 09:04 /usr/local/lib/libusb-1.0.so.0 -> libusb-1.0.so.0.1.0*`


注销重新登陆（ssh），恢复到被损坏的环境。
```
$ realsense-viewer
realsense-viewer: symbol lookup error: /usr/lib/x86_64-linux-gnu/librealsense2.so.2.50: undefined symbol: libusb_get_port_numbers
```

首先重试 reinstall libusb，查看动态库连接。
```
ldd /usr/bin/realsense-viewer |grep usb
        libusb-1.0.so.0 => /usr/local/lib/libusb-1.0.so.0 (0x00007f127b077000)
```
没有变，没有修复。--reinstall 不是解决办法。

尝试直接remove /usr/local/lib/libusb-1.0.so.0
`$ sudo mv /usr/local/lib/libusb-1.0.so.0  /usr/local/lib/libusb-1.0.so.0.bak`

```
$ ldd /usr/bin/realsense-viewer |grep usb
        libusb-1.0.so.0 => /lib/x86_64-linux-gnu/libusb-1.0.so.0 (0x00007f4f4ba32000)
```
自动指到了/lib/x86_64-linux-gnu/下的动态库文件。
修复了错误。

所以是LD_LIBRARY_PATH找的顺序有问题。
应该先找/lib/x86_64-linux-gnu 路径再找其他的。

看看重启会不会重新生成，找一下这个软连接的来源，以及这个动态库的来源。
`reboot`

没有重新生成。

怀疑不是重新生成，是重新指向。
创建一个指向/lib下的，
`$ sudo ln -s /lib/x86_64-linux-gnu/libusb-1.0.so.0 /usr/local/lib/libusb-1.0.so.0`

```
$ ll /lib/x86_64-linux-gnu/libusb-1.0.so.0
lrwxrwxrwx 1 root root 19 6月  25  2017 /lib/x86_64-linux-gnu/libusb-1.0.so.0 -> libusb-1.0.so.0.1.0
```

```
$ ldd /usr/bin/realsense-viewer  |grep usb
        libusb-1.0.so.0 => /usr/local/lib/libusb-1.0.so.0 (0x00007fb51b2f0000)
```
。。。还没改过来，注销，重新登陆。

```
$ ldd /usr/bin/realsense-viewer  |grep usb
        libusb-1.0.so.0 => /usr/local/lib/libusb-1.0.so.0 (0x00007f2787655000)
```
可以看到改过来了，此时是指向的对的/lib下的.so
`realsense-viewer`打开也没有问题。

此时重启一下。
```
$ ll  /usr/local/lib/libusb-1.0.so.0
lrwxrwxrwx 1 root root 37 6月  29 10:35 /usr/local/lib/libusb-1.0.so.0 -> /lib/x86_64-linux-gnu/libusb-1.0.so.0
```
并没有重新生成。
原因未知，先探索到这里。

再看一下/usr/local/libusb的来源这个问题。

usr（unix system resource缩写 not user）
/lib是内核级的,/usr/lib是系统级的,/usr/local/lib是用户级的.
猜测可能是安装kinect dk，然后附带了/usr/local/lib/libusb
有机会再验证。







## 总结

- 有些依赖多的库，如libusb，直接卸载再安装（remove ；install）可能会影响很多软件（autoremov gnome gdm e.t.c.），系统可能会炸。但是apt install --reinstall 不受影响，不会影响其他软件正常运行。
- nm -D 查看动态库内函数，或者使用readelf -aW查看更多信息。
- LD_LIBRARY_PATH 是系统除了默认搜索路径外的动态库搜索路径。
- locate 查找库文件路径
- 


---
/etc/ld.so.conf 此文件记录了编译时使用的动态库的路径，也就是加载so库的路径。  
默认情况下，编译器只会使用/lib和/usr/lib这两个目录下的库文件，而通常通过源码包进行安装时，如果不  
指定--prefix会将库安装在/usr/local目录下，而又没有在文件/etc/ld.so.conf中添加/usr/local/lib这个目录>。这样虽然安装了源码包，但是使用时仍然找不到相关的.so库，就会报错。也就是说系统不知道安装了源码包。  
对于此种情况有2种解决办法：  
（1）在用源码安装时，用--prefix指定安装路径为/usr/lib。这样的话也就不用配置PKG_CONFIG_PATH  
(2) 直接将路径/usr/local/lib路径加入到文件/etc/ld.so.conf文件的中。在文件/etc/ld.so.conf中末尾直接添加：/usr/local/lib（这个方法给力！）

**ldconfig**  
再来看看ldconfig这个程序，位于/sbin下，它的作用是将文件/etc/ld.so.conf列出的路径下的库文件缓存到/etc/ld.so.cache以供使用，因此当安装完一些库文件，或者修改/etc/ld.so.conf增加了库的新的搜索路径，需要运>行一下ldconfig，使所有的库文件都被缓存到文件/etc/ld.so.cache中，如果没做，可能会找不到刚安装的库。
