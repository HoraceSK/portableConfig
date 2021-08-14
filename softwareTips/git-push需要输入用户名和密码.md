# git push 需要输入用户名和密码
## reference
- [git push/pull每次都需要输入密码的原因分析及解决](https://blog.csdn.net/tsq292978891/article/details/89316612)
```bash
git config --global credential.helper 'cache --timeout 604800'  #  这里设置账号信息被记住7200秒，两个小时,一周是604800秒。
git config credential.helper store
```
- [解决 git pull/push 每次都要输入用户名密码的问题](https://www.jianshu.com/p/5b81c9ce505c)
