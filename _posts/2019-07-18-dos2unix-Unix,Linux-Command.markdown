---
layout: post
title:  "dos2unix-Unix, Linux Command"
date:   2019-07-18 17:49:01 +0800
categories: Linux
---
## NAME

dos2unix - DOS/MAC to UNIX text file format converter

## DESCRIPTION

The program that converts plain text files in DOS/MAC format to UNIX format.

## 命令介绍

dos2unix命令用来将DOS格式的文本文件转换成UNIX格式的（DOS/MAC to UNIX text file format converter）。DOS下的文本文件是以\r\n作为断行标志的，表示成十六进制就是0D 0A。而Unix下的文本文件是以\n作为断行标志的，表示成十六进制就是 0A。DOS格式的文本文件在Linux底下，用较低版本的vi打开时行尾会显示^M，而且很多命令都无法很好的处理这种格式的文件，如果是个shell脚本，。而Unix格式的文本文件在Windows下用Notepad打开时会拼在一起显示。因此产生了两种格式文件相互转换的需求，对应的将UNIX格式文本文件转成成DOS格式的是unix2dos命令。 

## 常用参数

将DOS格式文本文件转换成Unix格式，最简单的用法就是dos2unix直接跟上文件名。

格式：dos2unix file

如果一次转换多个文件，把这些文件名直接跟在dos2unix之后。（注：也可以加上-o参数，也可以不加，效果一样）

格式：dos2unix file1 file2 file3

格式：dos2unix -o file1 file2 file3

上面在转换时，都会直接在原来的文件上修改，如果想把转换的结果保存在别的文件，而源文件不变，则可以使用-n参数。

格式：dos2unix oldfile newfile

如果要保持文件时间戳不变，加上-k参数。所以上面几条命令都是可以加上-k参数来保持文件时间戳的。

格式：dos2unix -k file

格式：dos2unix -k file1 file2 file3

格式：dos2unix -k -o file1 file2 file3

格式：dos2unix -k -n oldfile newfile

注：unix2dos命令的使用方式与dos2unix命令的类似。

### cat -v 查看非打印字符

cat -v job.sh     <== cat -v可以看到文件中的非打印字符，而不带-v参数的cat命令不行。