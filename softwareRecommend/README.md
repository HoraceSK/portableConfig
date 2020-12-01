# Software Recommend
## 常用软件
下边分别介绍各常用软件，并在最后给出集中安装脚本。
### 办公软件
linux平台上的几大office软件，首选wps，libreoffice次之，freeoffice再次之。如今已经是2020年了，MS Office固然强大，但libreoffice也没有原地踏步，本人推荐libreoffice.
命令：`pacman -Siv libreoffice-fresh`；也可以`sudo pacman -S wps-office`.
为了这一步自己安装fresh版本而非stable版本的libreoffice，在安装界面直接选择不安装办公软件即可。
### 浏览器
系统自带的firefox虽说不错，但总觉得少了点什么。
我本人是推荐去火狐的官网下载语言为`English(UK)`的`Firefox Developer Editiion`，然后自己解压到`/opt/firefox`目录下。
再推荐三款:
```bash
#查看一下三款推荐的浏览器
pacman -Siv firefox-developer-edition
pacman -Siv google-chrome-dev
pacman -Siv brave
```
### 硬件监测工具
psensor这款软件可以监测系统硬件，免费开源，支持平台包括ubuntu/OpenSuse/Archlinux。
[psensor源代码](https://github.com/chinf/psensor)
[psensor is a graphical hardware temperature monitor for Linux.](https://wpitchoune.net/psensor/)
终端输入命令`pacman -Siv psensor`来查看相关信息。

### 下载工具
#### 磁力下载
就像迅雷那样使用，可以打开磁力链接，可以打开torrent种子。
qbittorrent和Motrix。后者更完美，但安装包足足300多M，空间有限的情况下可选择qbittorrent。
qbittorrent是一个文件共享程序，运行一个torrent文件时，数据会上传给其他用户。
```bash
sudo pacman -Siv qbittorrent
sudo pacman -Siv motrix-git
```
[Motrix的源代码](https://github.com/agalwood/Motrix/blob/master/README-CN.md)
#### 音乐视频下载
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

### 远程控制软件
推荐teamviewer和tigervnc。
```bash
# 查看如下两款软件：
pacman -Ss teamviewer
pacman -Ss tigervnc
```
还有一款开源但收费的B/S架构的远控软件[gotohttp](https://gotohttp.com/),可访问官网`https://gotohttp.com/goto/download.12x`下载。
### IDE软件
代码编辑器使用自带的Kate就可以了，Kate功能很强大。
这里推荐四个IDE，eclipse,pycharm,spyder和geany.
eclipse是写Java代码的绝佳IDE,PyCharm和Spyder写Python也是赫赫有名,geany则是支持多种语言的轻量级IDE.geany对代码补全支持不太好,因此十分适合初学代码的新手使用.需要注意的是,manjaro安装geany来写Python代码,还需要安装xterm,才可以使用虚拟终端在运行代码.
[xterm是什么？Xterm 是 Linux 和 UNIX 系统上最受欢迎的终端仿真器，因为它是 X 窗口系统的默认终端仿真器，并且很轻量、很简单。](https://linux.cn/article-8364-1.html)
[geany源代码地址](https://github.com/geany/geany)
```bash
pacman -Siv eclipse-java
pacman -Siv geany
```
#### python必装的library
装完IDE就要配置好python的库了。
下边列出常用的python第三方库:
```
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
注意:
1. 一定要`sudo`安装，否则library将安装在`~/.local/lib/python3.7/site-packages`,只能当前用户使用。而`sudo`安装，才能把library安装在`/usr/local/lib/python3.7/dist-packages`目录下，所有用户都可使用。
2. 安装selenium库必须安装浏览器的驱动才可以使用，如：
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
### 图像处理软件
推荐使用gimp,photoshop90%的功能它都有，安装后大小110.65 MiB:
`pacman -Siv gimp`
参考：
[Adobe Photoshop 的 4 种自由开源替代品](https://linux.cn/article-11474-1.html)
### 视频剪辑软件
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

### 录屏软件
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

### 思维导图工具
```bash
pacman -Siv freemind # 画思维导图的软件
pacman -Siv dia # 画流程图的软件
```
此外，yEd也是一款流程图工具，但该软件非开源，需要自行去[官网](https://www.yworks.com/downloads)下载相应软件导，到本地解压安装，该软件由`java`写成，故依赖`jre`。
参考：
[适用于Linux用户的10款出色的免费思维导图软件](https://www.linuxidc.com/Linux/2020-02/162417.htm)
[为Linux用户推荐几种免费思维导图软件](https://linux265.com/news/3925.html)
### 笔记软件(支持markdown)
```bash
pacman -Siv vnote-git
pacman -Siv qownnotes
pacman -Siv typora
```
这几篇文章可以参考，不过本人还是认为vnote最优秀,其次是qownnotes，此外`typora`也是一款很不错的markdown笔记软件，但值得注意的是，该软件非开源。
[Linux 上 10 个最好的 Markdown 编辑器](https://locez.com/translation/best-markdown-editors-for-linux/)
[8 个优秀的开源 Markdown 编辑器](https://linux.cn/article-8531-1.html)
[9 款 Linux 上的最佳笔记应用 - 知乎](https://zhuanlan.zhihu.com/p/147710625)
### 网盘软件
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
### 音乐播放软件
网易云音乐有linux版本哦。
```bash
#网易云音乐有多个版本，随便选一个就行：
pacman -Siv netease-cloud-music
pacman -Siv netease-cloud-music-gtk
pacman -Siv netease-musicbox #命令行版本的网易云音乐
```
## 其他软件
wire:前端到后端都开源的即时通讯软件。
flameshot：很好用的截图软件
typora:markdown软件,其实我自己用的是vnote-git,有些地方的确比vnote优化的好,比如可以即时渲染，但是软件太大了，安装完了180M，而vnote只有6M，且vnote功能更多。
simplescreen recorder:录屏软件
tigervnc:局域网内的开源的远程控制软件
geogebra:一个数学软件，不知道是不是类似mathematica

