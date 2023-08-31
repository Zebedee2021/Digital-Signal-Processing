GitHub使用技巧

##### 一、 解决 Github port 443 : Timed out

修订：2023.8.31 

参考：
https://zhuanlan.zhihu.com/p/636418854
https://ericclose.github.io/git-proxy-config.html
https://gist.github.com/laispace/666dd7b27e9116faece6

（1）仅为 github 设置代理 (推荐)
如下设置仅在使用 GitHub 时会走本机代理，使用其他平台如 Gitee 时就可以直连
git config --global http.https://github.com.proxy socks5://127.0.0.1:7890

取消代理设置
git config --global --unset http.https://github.com.proxy

（2）直接设置 git 代理
让所有 Git HTTPS 流量走本机 socks5 代理
git config --global http.proxy socks5://127.0.0.1:7890

取消代理设置
git config --global --unset http.proxy

#### 操作：
在VS Code终端运行如下命令，可以解决问题：
设置代理
git config --global http.https://github.com.proxy socks5://127.0.0.1:7890
git config --global http.proxy socks5://127.0.0.1:7890

检测代理
git config --global --get http.proxy  
git config --global --get https.proxy

取消代理
git config --global --unset http.https://github.com.proxy
git config --global --unset http.proxy

