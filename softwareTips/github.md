# github.com 访问速度很慢的问题解决
[完美解决github访问速度慢 - 月正明的文章 - 知乎](https://zhuanlan.zhihu.com/p/93436925)
获取Github相关网站的ip
访问https://www.ipaddress.com，拉下来，找到页面中下方的“IP Address Tools – Quick Links”
分别输入github.global.ssl.fastly.net和github.com，查询ip地址
在`/etc/hosts`文件末尾写入如下查询结果：
```bash
140.82.114.4	github.com
199.232.5.194	github.global.ssl.fastly.net
```
