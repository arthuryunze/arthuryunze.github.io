
解决virtualbox下共享文件夹权限问题
```
sudo usermod -aG vboxsf $(whoami)
```