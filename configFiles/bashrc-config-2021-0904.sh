# customized:
## 自定义命令提示符：
PS1='\[\033[01;32m\][\u]\[\033[00m\][\[\033[01;34m\]\w\[\033[00m\]]\n==>[\#]\$ '

<<<<<<< HEAD:bashrc-config-2020-1107.txt
# PS1="=>[\#][\u][\w]\$ "
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u]\[\033[00m\][\[\033[01;34m\]\w\[\033[00m\]]\n==>[\#]\$ '
=======
#PS1="=>[\#][\u][\w]\$ "
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u]\[\033[00m\][\[\033[01;34m\]\w\[\033[00m\]]\n==>[\#]\$ '

# ok:
PS1='\[\033[01;32m\][\u]\[\033[00m\][\[\033[01;34m\]\w\[\033[00m\]]\n==>[\#]\$ '

>>>>>>> 91a63bcc68b1dc6a93df98b978e04b2c340b5872:config/bashrc-config-2020-1107.txt

## 命令简化：
alias rm='rm -i'
alias ll="ls -hl --color=auto"
alias cl='clear'
alias cll='clear & ls -hl'
alias how='du -h -d 1 ./'

alias sshgo="systemctl start sshd.service"
alias sshoff="systemctl stop sshd.service"

# 挂载坚果云网盘，注意需要一个临时密码，需要登录网页版坚果云设置获取
alias mdav='sudo mount -t davfs https://dav.jianguoyun.com/dav/ ~/media/y-nutStore/'

## 启动软件：
alias syncon='syncthing -no-browser & exit'
alias syncedit='syncthing -browser-only & exit'

alias web="elinks -anonymous 1 "
alias doge="elinks -anonymous 1 www.dogedogego.com"

alias tor="tor-browser & exit"
alias ggchm="/usr/bin/google-chrome-unstable --incognito"
alias chrome="/usr/bin/google-chrome-unstable --incognito & exit"

alias vlc="/usr/bin/vlc"
alias ffx="/opt/firefox/firefox"
alias ffd="/opt/firefox/firefox & exit"
alias tmv="/opt/teamviewer/teamviewer & exit"

# virtual machine manage:
alias debianon='vboxmanage startvm debian --type headless'
alias debianoff='vboxmanage controlvm debian poweroff'

# functions:
function findf (){
find . -type f -name '*'$1'*';
};
function findd (){
find . -type d -name '*'$1'*';
};
function findsk(){
echo '-----files:-----';
find . -type f -name '*'$1'*';
echo '-----folders:-----';
find . -type d -name '*'$1'*';
};
