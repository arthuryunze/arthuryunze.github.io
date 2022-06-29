---
catagories: 运维
description: LAMP安装配置
---

这篇文章旨在记录Ubuntu+apache2+MySQL8环境下升级PHP版本（无缝升级）的经过。

## 原因

因某次手贱升级了MySQL数据库（版本从5到8），导致MySQL与php的兼容出了问题。  
Ubuntu阿里源安装的PHP版本是7.0.3的。这个版本的PHP是不支持MySQL8新的加密方式的（caching_sha2_password），所以PHP项目在连接数据库时就会出现连接失败的问题。phpmyadmin也无法登录。

起初以为是root的远程访问权限出了问题，因为我的root权限是只限本机的（localhost），后来通过创建新的具有远程访问权限的用户发现还是无法连接，知道了跟用户权限没关系。  

> （Linux再也不随便升级东西了，有些软件升级后，废弃的特性和新的特性会影响各种配置）。

## 解决方案

> 找到解决方案前尝试了
> 1. 修改my.cnf，发现没有这个文件，且添加文件并修改也没有效果  
> 2. 修改账户密码加密方式，修改后无效果

添加PHP源，这个时候PHP版本最新是7.4版本。

`add-apt-repository ppa:ondrej/php`

`sudo apt update`

`sudo apt upgrade php`

`sudo apt install php-mysql` 安装php mysql扩展。

至此，查看phpinfo界面，发现版本还是7.0，说明服务器没有使用新的版本。

查看apache2相关配置文件后，发现php是以插件的形式存在于apache2服务器中的（在/etc apache2 中什么mods enable路径下可以找到），可以使用命令打开关闭。

关闭php7.0，开启php7.4。

`sudo a2dismod php7.0`

`sudo a2enmod php7.4`

重启apache2服务器

`sudo service apache2 restart`

至此，服务器上的php升级完成。phpinfo页的版本也已经更新。( •̀ ω •́ )y

---

Reference：

[(11条消息)phpmyadmin连接MySQL8.0报错#2054 - The server requested authentication method unknown to the client_数据库_weixin_40208575的博客-CSDN博客](https://blog.csdn.net/weixin_40208575/article/details/84961976)

[SHA2密码验证引起的PHP错误：SQLSTATE[HY000] [2054] The server requested authentication method unknown to the client - 有欲 - 博客园](https://www.cnblogs.com/cndavidwang/p/9357684.html)

[Ubuntu PHP7.0 升级到 7.1 Laravel China 社区](https://learnku.com/articles/6845/ubuntu-php70-upgrade-to-71)

[(11条消息)PHP错误：SQLSTATE[HY000] [2054] The server requested authentication method unknown to the client_php_xiaoxinshuaiga的博客-CSDN博客](https://blog.csdn.net/xiaoxinshuaiga/article/details/82798919)

[MySQL用户管理：添加用户、授权、删除用户 - 陈树义 - 博客园](https://www.cnblogs.com/chanshuyi/p/mysql_user_mng.html)