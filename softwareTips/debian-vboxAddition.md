# debian 安装 virtualbox-guest-additions-iso 奇遇记
## 1. 先要安装`linux-headers`
```bash
apt search linux-headers|grep $(uname -r)
```
如上述命令找不到结果，则选取与`uname -r`大版本号最相近的`linux-headers`版本安装上。
## 2. 检查已安装的`linux-image`与`linux-headers`版本是否一致
只要两者版本号**完全一致**，即可成功安装`virtualbox-guest-additions-iso`。
控制virtualbox插入iso光盘，将里边的文件拷贝出来，执行`sudo sh ./autorun.sh`即可.
