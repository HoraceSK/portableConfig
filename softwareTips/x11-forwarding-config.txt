# 解决 Arch Linux X11 转发不启用的问题
## 参考链接
- [ref_link](https://blog.csdn.net/taotieren/article/details/106490662)
## 描述
- 1. 安装`xorg-xauth`。
- 2.创建`~/.Xauthority`文件。
```bash
touch ~/.Xauthority && chmod 600 ~/.Xauthority
```

- 3. 编辑`/etc/ssh/sshd_config`，在最后添加(或者更改相应设置为)如下内容：
```bash
# Enable x11 forwarding:
Port 22
AddressFamily inet
PermitRootLogin prohibit-password
StrictModes yes
MaxAuthTries 6
MaxSessions 10
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/authorized_keys
PasswordAuthentication yes
PermitEmptyPasswords yes
ChallengeResponseAuthentication no
UsePAM yes
AllowAgentForwarding yes
AllowTcpForwarding yes
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
TCPKeepAlive yes
```
- 4. 重启ssh服务。
```bash
sudo systemctl reload sshd.service
sudo systemctl restart sshd.service
```
