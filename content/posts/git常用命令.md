---
title: "git常用命令"
date: 2020-02-19T16:57:58+08:00
draft: false
---

---
description: Git syntax
categories: Tool Git
---


项目提交时:
---
- git add -A  提交所有变化
- git add -u  提交被修改(modified)和被删除(deleted)文件，不包括新文件(new)
- git add .  提交新文件(new)和被修改(modified)文件，不包括被删除(deleted)文件

git pull 拉取远程仓库,覆盖本地文件,本地其它改动不会受到影响.

项目更改时:
---

`git commit -m "本功能全部完成"` 提交后

若需要**撤回commit并保留代码**

可执行 `git reset --soft HEAD^` 以撤销上次commit


HEAD^的意思是上一个版本，也可以写成HEAD~1

如果进行了2次commit，想都撤回，可以使用HEAD~2

几个参数:  
* `--mixed`  
不删除工作空间改动代码，撤销commit，并且撤销git add . 操作
这个为默认参数,即 `git reset --mixed HEAD^` 和 `git reset HEAD^` 效果是一样的。
* `--soft`  
不删除工作空间改动代码，撤销commit，不撤销git add . 
* `--hard`  
删除工作空间改动代码，撤销commit，撤销git add . 

注意完成这个操作后，就恢复到了上一次的commit状态。

如果commit注释写错了，只是想改一下注释，只需要: `git commit --amend`  
此时会进入默认vim编辑器，修改注释完毕后保存就好了。

项目拉取时
---

git pull 不带任何参数，拉取当前分支。

### 问题

fatal: refusing to merge unrelated histories

### 原因

两个分支没有取得关系

### 解决
git merge 后加参数 --allow-unrelated-histories