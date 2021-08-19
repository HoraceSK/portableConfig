# VirtualBox
## debian 安装`virtualbox-guest-additions-iso`失败 
debian插入虚拟光驱之后,安装`virtualbox-guest-additions-iso`之后,没有应有的扩展效果,解决方法如下:
### 1. 先要安装`linux-headers`

```bash
apt search linux-headers|grep $(uname -r)
```

如上述命令找不到结果，则选取与`uname -r`大版本号最相近的`linux-headers`版本安装上。
### 2. 检查已安装的`linux-image`与`linux-headers`版本是否一致
只要两者版本号**完全一致**，即可成功安装`virtualbox-guest-additions-iso`。
控制virtualbox插入iso光盘，将里边的文件拷贝出来，执行`sudo sh ./autorun.sh`即可.

## 宿主机的文件夹共享给虚拟机之后,进入虚拟机,无权限访问共享文件夹.
文件夹共享并自动挂载依赖于`virtualbox-guest-additions-iso`.
安装好`virtualbox-guest-additions-iso`之后,只要让当前用户加入`vboxsf`组即可. <br>
[参考文章](https://www.cnblogs.com/zhuguanhao/p/6192777.html)

### 1. 查看`vsboxsf`组的`gid`

```bash
tail /etc/group |grep vboxsf
vboxsf:x:109
```

### 2. 让当前用户加入`vboxsf`组

```bash
sudo usermod -a -G 109 $(whoami)
```

上述操作之后,会立即生效,直接进入共享文件夹即可.
