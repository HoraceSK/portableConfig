# Manjaro Linux Customized Configuration
## 1.初始设置
因为需要编辑配置文件,最好提前安装好vim。更换国内源之前网速会比较慢。
```
sudo pacman -S vim
touch ~/.vimrc
```
添加以下内容到~/.vimrc:
```bash
filetype indent on
set encoding=utf-8
set nobackup
set autochdir
set visualbell
set history=30
set autoread

set t_Co=256
set number
set cursorline
set laststatus=2
set ruler
set showmatch

set hlsearch
set incsearch
set smartcase

syntax on
set showmode
set showcmd
set wrap
set linebreak
set wrapmargin=2

set autoindent
set shiftwidth=4
set expandtab
set softtabstop=4
set ts=4
%retab!
```
### 1.1 更换软件源并调整时间显示
#### 更新镜像排名
```
sudo pacman-mirrors -i -c China -m rank  #更新镜像排名
sudo vim /etc/pacman.d/mirrorlist  #查看选择的源
sudo pacman -Syy  #更新数据源
```
#### 编辑配置文件/etc/pacman.conf
```
sudo vim /etc/pacman.conf
```
```
这是我自己写的配置,SigLevel也可以写成Never.
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

#[archlinuxcn]
#SigLevel = Optional TrustedOnly
#Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
[blackarch]
SigLevel = Optional TrustAll
Server = https://mirrors.ustc.edu.cn/blackarch/$repo/os/$arch
```
编辑完成之后，记得sudo pacman -Syy更新数据源。
#### 安装并配置AUR软件包管理工具

```
sudo pacman -S yay
yay –aururl “https://aur.tuna.tsinghua.edu.cn” –save
#修改的配置文件位于 ~/.config/yay/config.json ，还可通过以下命令查看修改过的配置：
yay -P -g
```
参考：
[yay如何换国内aur镜像源](https://manjaro.org.cn/bbs/topic/yay%E5%A6%82%E4%BD%95%E6%8D%A2%E5%9B%BD%E5%86%85%E9%95%9C%E5%83%8F%E6%BA%90)
#### 更新源
```bash
yay -Syy # yay操作不需要sudo
sudo pacman -Syy #更新数据源
#安装导入GPG key,GNU Privacy Guard （简称GnuPG或GPG）是一种加密软件，它是PGP加密软件的开源替代程序。GnuPG是一个混合加密软件程序，可以使用多种非专利的算法。
sudo pacman -S archlinuxcn-keyring
```
#### 升级系统
做完以上配置之后，对系统进行全面升级，以便进行后续配置。
```sudo pacman -Syyu```

### 1.2 新增用户
```bash
# 添加自己的常用用户:
sudo useradd -m [username] # [username]只是一个例子
sudo visudo /etc/sudoers
# 找到"## User privilege specification"这一行,下边添加:
# [username] ALL=(ALL) ALL
# 找到"Default ...."这一行，添加：
Defaults        env_reset,pwfeedback
# 之后添加访客用户:
sudo useradd -m guest
sudo passwd guest
```
后边的操作都是使用常用用户**[username]**操作了.
### 1.3 中文输入法
输入法不着急装,先把配置文件准备好,重启之后就直接生效了.
```bash
vim ~/.xprofile,或 vim ~/.pam_environment(两个名字好像都可以)
# 写入以下内容
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
# 如下输入法选择其一安装即可：
sudo pacman -Siv fcitx-sunpinyin
sudo pacman -S fcitx-sunpinyin
sudo pacman -Siv fcitx-libpinyin
sudo pamcna -S fcitx-libpinyin
#有时候需要额外安装kcm-fcitx:
sudo pacman -S kcm-fcitx
```

### 1.4 把Windows系统下的字体复制过来
Windows字体存放的目录:
`C:\Windows\Fonts`；
Linux字体存放的目录:
`usr/share/fonts/`；
直接把所有字体文件复制到相应文件夹即可。
### 1.5 系统界面、图标、主题等
- 把标题栏按钮都放到左边去
- 图标主题选个好看的
- 常用软件固定到任务栏和开始菜单

## 2.自定义脚本和命令别名
### 2.1 自动挂载/反挂载磁盘
本来直接编辑`/etc/fstab`就不用自动挂载卸载了，但这不利于其他硬盘/分区的数据保护，还是等到使用的时候临时挂载比较好。
首先要创建挂载点，根据自己需要哦，为windows系统的D、E、F盘创建挂载点的脚本如下啊:
```bash
#!/usr/bin/bash
mkdir ~/media
cd ~/media
mkdir {d,e,f}-pan
mkdir share
mkdir zlinshi
```
自动挂载的脚本：`vim ~/.automount.sh`,写入以下内容：
```bash
#!/usr/bin/bash
sudo mount /dev/sda5 /home/[username]/media/d-pan
sudo mount /dev/sda6 /home/[username]/media/e-pan
sudo mount /dev/sda7 /home/[username]/media/f-pan
sudo mount /dev/sda8 /home/[username]/media/share
```
自动卸载磁盘的脚本:`vim ~/.umountall.sh`，写入以下内容：
```
#!/usr/bin/bash
sudo umount /home/[username]/media/d-pan
sudo umount /home/[username]/media/e-pan
sudo umount /home/[username]/media/f-pan
sudo umount /home/[username]/media/share
#sudo swapon /dev/sda9
#cp ~/.bashrc /home/[username]/media/share/linux-backup/custom-cmd.txt
```

### 2.2 自动开启swap分区
创建文件`vim ~/.swapGo.sh`，写入以下内容。
```bash
#!/usr/bin/bash
sudo swapon /dev/sda9
sudo sysctl vm.swappiness=100
```
当然自动挂载swap还可以`sudo vim /etc/fstab`,写入以下内容：
```bash
/dev/sda9       swap    swap    defaults        0       0
```
如果电脑性能不佳，建议将`vm.swappiness`的值设为`100`。操作如下：
```bash
# 永久设置vm.swappiness=100
sudo echo "vm.swappiness=100" >> /etc/sysctl.d/99-swappiness.conf
```
如需要临时设置`vm.swappiness`，则在终端中输入`sudo sysctl vm.swappiness=100`，回车即可。
### 2.3 自动启用teamviewer服务
如果不启用teamviewer服务，则无法连接teamviewer服务器。脚本内容如下：
```bash
#!/usr/bin/bash
sudo systemctl stop teamviewerd.service
sudo systemctl start teamviewerd.service
```
### 2.4 命令别名与个性化终端命令提示符（.bashrc, .bash_profile）
编辑 `vim ~/.bashrc`,在最后增加如下内容：
```
# customized:

## 自定义命令提示符：
# PS1="=>[\#][\u][\w]\$ "
PS1='\[\033[01;32m\][\h][\[\033[01;37m\]\w\[\033[01;32m\]]\n==>[\#][\u]\$\[\033[00m\] '
## 命令简化：
alias rm='rm -i'
alias ll="ls -hl --color=auto"
alias cl='clear'
alias cll='clear & ls -hl'
alias sshgo="systemctl start sshd.service"
alias sshoff="systemctl stop sshd.service"
alias swapgo='sudo swapon /dev/sda9'
alias swapgone='sudo swapoff /dev/sda9'
# sudo sysctl vm.swapiness=100
# cat /proc/sys/vm/swappiness

## 启动软件：
alias syncon='syncthing -no-browser & exit'
alias web="w3m -num"
alias bing="w3m -num https://www.cn.bing.com/"
alias doge="w3m -num https://www.dogedoge.com/"
alias tor="tor-browser & exit"
alias ggchm="/usr/bin/google-chrome-unstable --incognito"
alias chrome="/usr/bin/google-chrome-unstable --incognito & exit"
alias vlc="/usr/bin/vlc"
alias tmv="/opt/teamviewer/teamviewer & exit"
alias mdav='sudo mount -t davfs https://dav.jianguoyun.com/dav/ /home/skhp/media/y1-nutStore/'
```
## 3.常用软件
下边分别介绍各常用软件，并在最后给出集中安装脚本。
### 3.1 办公软件
linux平台上的几大office软件，首选wps，libreoffice次之，freeoffice再次之。如今已经是2020年了，MS Office固然强大，但libreoffice也没有原地踏步，本人推荐libreoffice.
命令：`pacman -Siv libreoffice-fresh`；也可以`sudo pacman -S wps-office`.
为了这一步自己安装fresh版本而非stable版本的libreoffice，在安装界面直接选择不安装办公软件即可。
### 3.2 浏览器
系统自带的firefox虽说不错，但总觉得少了点什么。
我本人是推荐去火狐的官网下载语言为`English(UK)`的`Firefox Developer Editiion`，然后自己解压到`/opt/firefox`目录下。
再推荐三款:
```bash
#查看一下三款推荐的浏览器
pacman -Siv firefox-developer-edition
pacman -Siv google-chrome-dev
pacman -Siv brave
```
### 3.3 硬件监测工具
psensor这款软件可以监测系统硬件，免费开源，支持平台包括ubuntu/OpenSuse/Archlinux。
[psensor源代码](https://github.com/chinf/psensor)
[psensor is a graphical hardware temperature monitor for Linux.](https://wpitchoune.net/psensor/)
终端输入命令`pacman -Siv psensor`来查看相关信息。

### 3.4 下载工具
#### 3.4.1 磁力下载
就像迅雷那样使用，可以打开磁力链接，可以打开torrent种子。
qbittorrent和Motrix。后者更完美，但安装包足足300多M，空间有限的情况下可选择qbittorrent。
qbittorrent是一个文件共享程序，运行一个torrent文件时，数据会上传给其他用户。
```bash
sudo pacman -Siv qbittorrent
sudo pacman -Siv motrix-git
```
[Motrix的源代码](https://github.com/agalwood/Motrix/blob/master/README-CN.md)
#### 3.4.2 音乐视频下载
想要下载B站、youtube的视频？腾讯视频客户端下载的文件只能用腾讯视频播放？
为解决以上问题，推荐两个工具：you-get和youtube-dl-git，这两个工具仅有10M左右的大小。
```bash
#查看这两款软件：
pacman -Siv you-get
pacman -Siv youtube-dl-git
#安装：
sudo pacman -S you-get
sudo pacman -S youtube-dl-git
```

### 3.5 远程控制软件
推荐teamviewer和tigervnc。
```bash
# 查看如下两款软件：
pacman -Ss teamviewer
pacman -Ss tigervnc
```
还有一款开源但收费的B/S架构的远控软件[gotohttp](https://gotohttp.com/),可访问官网`https://gotohttp.com/goto/download.12x`下载。
### 3.6 IDE软件
代码编辑器使用自带的Kate就可以了，Kate功能很强大。如需更强大的编辑器，vscode值得入手。
这里推荐四个IDE，eclipse,pycharm,spyder和geany.
eclipse是写Java代码的绝佳IDE,PyCharm和Spyder写Python也是赫赫有名,geany则是支持多种语言的轻量级IDE.geany对代码补全支持不太好,因此十分适合初学代码的新手使用.需要注意的是,manjaro安装geany来写Python代码,还需要安装xterm,才可以使用虚拟终端在运行代码.
[xterm是什么？Xterm 是 Linux 和 UNIX 系统上最受欢迎的终端仿真器，因为它是 X 窗口系统的默认终端仿真器，并且很轻量、很简单。](https://linux.cn/article-8364-1.html)
[geany源代码地址](https://github.com/geany/geany)
```bash
pacman -Siv eclipse-java
pacman -Siv geany
```
#### 3.6.1 python必装的library
装完IDE就要配置好python的库了。
下边列出常用的python第三方库:
```text
numpy
pandas
scrapy
scipy
sklearn
openpyxl, xlrd, xlwt
python-docx
selenium
matplotlib
pyecharts
Faker
```
**使用`sudo pip install [libraryName] `安装上述library。**
如想批量安装，则将上述lib的名称列出保存到`./pylib.txt`文件中，并执行命令`sudo pip install -r ./pylib.txt`
注意:
- 1. 一定要`sudo`安装，否则library将安装在`~/.local/lib/python3.7/site-packages`,只能当前用户使用。而`sudo`安装，才能把library安装在`/usr/local/lib/python3.7/dist-packages`目录下，所有用户都可使用。
- 2. 安装selenium库必须安装浏览器的驱动才可以使用，如：
```bash
#!/usr/bin/bash
#arch系linux安装：
pacman -Siv archlinuxcn/chromedriver
sudo pacman -S archlinuxcn/chromedriver
pacman -Siv geckodriver
sudo pacman -S geckodriver
#debian系linux安装：
apt show chromium-driver
sudo apt install chromium-driver
```
#### 3.6.2 安装jdk
jdk是`Java Development Toolkit`的缩写，写Java的都知道。安装命令如下：
```bash
sudo pacman -Siv extra/jdk-openjdk
```
### 3.7 图像处理软件
推荐使用gimp,photoshop90%的功能它都有，安装后大小110.65 MiB:
`pacman -Siv gimp`
参考：
[Adobe Photoshop 的 4 种自由开源替代品](https://linux.cn/article-11474-1.html)
### 3.8 视频剪辑软件
其实系统自带了一个：
`pacman -Qiv ffmpeg`
推荐使用kdenlive，很不错。(A non-linear video editor for Linux using the MLT videoframework)。
`pacman -Siv kdenlive`
shotcut，没有转场功能，但体积小巧。(Cross-platform Qt based Video Editor)。
`pacman -Siv shotcut`
此外，openshot和Pitivi也不错，作为备选推荐。
```bash
pacman -Siv openshot
pacman -Siv pitivi
```
```html
如果你想要好莱坞级别的视频编辑器，那就用好莱坞正在使用的专业工具。来自 Blackmagic 公司的 DaVinci Resolve 就是专业人士用于编辑电影和电视节目的专业工具。
DaVinci Resolve 不是常规的视频编辑器。它是一个成熟的编辑工具，在这一个应用程序中提供编辑，色彩校正和专业音频后期制作功能。
DaVinci Resolve 不开源。类似于 LightWorks，它也为 Linux 提供一个免费版本。专业版售价是 $300。
PiTiVi 是一个使用 Python 所写并基于 GStreamer 和 GTK+ 的开源视频编辑软件。适用于编辑视频的新手，以及专业人员。它提供一个时间轴，以便对视频实现完全的控制。PiTiVi 还具有插件系统用来扩展现有的功能，如创建幻灯展示、编辑字幕等等。
```
参考：
[Linux 上最好的 9 个免费视频编辑软件（2018）](https://zhuanlan.zhihu.com/p/48413946)
[【教程】Shotcut视频剪辑软件使用](https://zhuanlan.zhihu.com/p/38419089)

### 3.9 录屏软件
开源的录屏软件推荐两款：obs-studio和simplescreenrecorder。
simplescreenrecorder操作简单容易上手，甚至不需要教程，打开软件就知道怎么使用了，可设置快捷键但无法停驻在系统托盘。
obs-studio，跨平台(有windows版)功能更全，更复杂，也更加强大。
```bash
pacman -Siv obs-studio
pacman -Siv simplescreenrecorder
```
[simplescreenrecorder源代码:](https://github.com/MaartenBaert/ssr)
[obs-studio源代码地址](https://github.com/obsproject/obs-studio)
[obs-studio教程from bilibili.com](https://www.bilibili.com/video/BV1XW411W7tH?from=search&seid=5777613593599165480)
[obs-studio简明教程from bililbili](https://www.bilibili.com/video/BV1kW411K7HA/?spm_id_from=333.788.videocard.0)
[直播+录制？一个软件搞定！obss详细讲解](https://www.bilibili.com/video/BV1vs411a7Gj/?spm_id_from=333.788.videocard.1)

### 3.10 思维导图工具
```bash
pacman -Siv freemind # 画思维导图的软件
pacman -Siv dia # 画流程图的软件
```
此外，yEd也是一款流程图工具，但该软件非开源，需要自行去[官网](https://www.yworks.com/downloads)下载相应软件导，到本地解压安装，该软件由`java`写成，故依赖`jre`。
参考：
[适用于Linux用户的10款出色的免费思维导图软件](https://www.linuxidc.com/Linux/2020-02/162417.htm)
[为Linux用户推荐几种免费思维导图软件](https://linux265.com/news/3925.html)
### 3.11 笔记软件(支持markdown)
```bash
pacman -Siv vnote-git
pacman -Siv qownnotes
pacman -Siv typora
```
这几篇文章可以参考，不过本人还是认为vnote最优秀,其次是qownnotes，此外`typora`也是一款很不错的markdown笔记软件，但值得注意的是，该软件非开源。
[Linux 上 10 个最好的 Markdown 编辑器](https://locez.com/translation/best-markdown-editors-for-linux/)
[8 个优秀的开源 Markdown 编辑器](https://linux.cn/article-8531-1.html)
[9 款 Linux 上的最佳笔记应用 - 知乎](https://zhuanlan.zhihu.com/p/147710625)
### 3.12 网盘软件
百度网盘和坚果云网盘都有linux版本哦。
```bash
pacman -Siv nutstore
pacman -Siv baidupcs-go #命令行版本的百度网盘
pacman -Siv baidunetdisk-bin
```
要挂载坚果云网络文件夹，还需要安装`davfs2`,
```bash
pacman -Siv davfs2
sudo pacman -S davfs2
```
安装后修改davfs2的配置，`sudo vim /etc/davfs2/davfs2.conf`,找到`ignore_dav_header`这一行，取消注释并修改参数值为：
```bash
ignore_dav_header 1
```
接着用浏览器登录[坚果云](https://www.jianguoyun.com/d/login),进入`设置-账户-安全-第三方应用管理`,添加新设备并生成密码,然后挂载坚果云网络文件夹到本地目录，输入账号啊和设定的密码即可。
```bash
sudo mount -t davfs  https://dav.jianguoyun.com/dav/ [your local directory]
```
reference:
[多平台挂载坚果云-官方教程](https://www.leeyiding.com/archives/47/)
[解决Linux下使用davfs2挂载坚果云的问题](https://zohead.com/archives/davfs2-nutstore/)
### 3.13 音乐播放软件
网易云音乐有linux版本哦。
```bash
#网易云音乐有多个版本，随便选一个就行：
pacman -Siv netease-cloud-music
pacman -Siv netease-cloud-music-gtk
pacman -Siv netease-musicbox #命令行版本的网易云音乐
```
