# pacman
## makepkg遇到问题ERROR: Cannot find the strip binary required for object file stripping.
解决方法:
```bash
sudo pacman -Sy base-devel
```
参考链接:[==> ERROR: Cannot find the strip binary required for object file stripping](https://www.jianshu.com/p/e053d0ac1212)

## 全面更新系统时有两个包无法更新(否则破坏依赖)
终极解决方案是更新时直接忽略这两个包.<br>
千万不可直接卸载,否则无法进入桌面环境.<br>
友情提示:**任何疑似危险的操作都应当在虚拟机中先尝试,确认没问题后再操作.**

```bash
sudo pacman -Syyu --noconfirm --ignore lib32-libcanberra --ignore libcanberra
```
