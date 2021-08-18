# github使用中的问题
## git push需要输入 用户名和密码
### 解决方法

```bash
# 方法一:
git config --global credential.helper 'cache --timeout 604800'  #  这里设置账号信息被记住7200秒，两个小时,一周是604800秒。
# 方法二:
git config credential.helper store
```
### 参考链接
- [git push/pull每次都需要输入密码的原因分析及解决](https://blog.csdn.net/tsq292978891/article/details/89316612)
- [解决 git pull/push 每次都要输入用户名密码的问题](https://www.jianshu.com/p/5b81c9ce505c)

## 访问速度慢
### 解决方法
获取Github相关网站的ip
访问https://www.ipaddress.com，拉下来，找到页面中下方的“IP Address Tools – Quick Links”
分别输入github.global.ssl.fastly.net和github.com，查询ip地址
在`/etc/hosts`文件末尾写入如下查询结果：

```bash
140.82.114.4	github.com
199.232.5.194	github.global.ssl.fastly.net
```

### 参考链接
[完美解决github访问速度慢 - 月正明的文章 - 知乎](https://zhuanlan.zhihu.com/p/93436925)
