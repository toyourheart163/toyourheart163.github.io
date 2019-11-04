---
layout:     post
title:      黑客工具
subtitle:   黑客工具
date:       2019-11-01
author:     TY
header-img: img/
catalog: true
toc: true
tags: [netcat, nmap, termux, tmux]
---

# 黑客工具

- netcat
- nmap
- termux
- tmux


## netcat 网猫--网络上的瑞士军刀

```
---------------------
|      /\_/\        |
|     / 0 0 \       |
|    ====v====      |
|     \  W  /       |
|     |     |     _ |
|     / ___ \    /  |
|    / /   \ \  |   |
|   (((-----)))-'   |
|    /              |
|   (      ___      |
|    \__.=|___E     |
|           /       |
---------------------
```

1. 传文件
- 接收主机 `nc -l -p 6666 > file`
- 发送主机 `nc localhost 6666 < file`

2. 扫描端口 `nc -znv 192.168.0.100 1-1024`

## nmap 扫描端口

`nmap www.baidu.com`

## termux, android terminal

从F-Droid应用商店安装
使用方法，搜索**[国光termux](https://www.sqlsec.com/2018/05/termux.html)**，可以了解到白帽子黑客使用的工具

## tmux 终端复用器

1. ssh连接，持久session，万一网络断开了，重新连接后的东西不见了，就用到tmux
    ```zsh
    tmux ls # 列出使用的session
    tmux attach -t 0  # 切换到第0个
    ```

3. 窗格快捷键

```
Ctrl+b %：划分左右两个窗格。
Ctrl+b "：划分上下两个窗格。
Ctrl+b <arrow key>：光标切换到其他窗格。<arrow key>是指向要切换到的窗格的方向键，比如切换到下方窗格，就按方向键↓。
Ctrl+b ;：光标切换到上一个窗格。
Ctrl+b o：光标切换到下一个窗格。
Ctrl+b {：当前窗格左移。
Ctrl+b }：当前窗格右移。
Ctrl+b Ctrl+o：当前窗格上移。
Ctrl+b Alt+o：当前窗格下移。
Ctrl+b x：关闭当前窗格。
Ctrl+b !：将当前窗格拆分为一个独立窗口。
Ctrl+b z：当前窗格全屏显示，再使用一次会变回原来大小。
Ctrl+b Ctrl+<arrow key>：按箭头方向调整窗格大小。
Ctrl+b q：显示窗格编号。
```

## 查找文件fd, 替代find

###　安装`brew install fd`

[fd 官网](https://github.com/sharkdp/fd)
```zsh
fd .  # 递归查找
fd -e py # 查找py结尾的文件
```


## 查找文件里的字符 `grep`

```zsh
grep -r "word" .
# exclude 除了此文件夹，include 是此文件夹
grep -R --exclude-dir={node_modules,} "mock" .
```

## 从github下载单个文件夹或文件`fetcher`

安装 `npm install -g github-files-fetcher`

获取文件 `fetcher --url="https://github.com/toyourheart163/toyourheart163.github.io/blob/master/_posts/2019-11-01-hack-tools.md --out=hack-tool.md"`

## Autojump

不用`cd`半天

跳到download文件夹`j down`

## 输入法rime

[rime](https://rime.im)

可以用emacs的快捷键，当然在windows上快捷键就不怎么好用了。不要在win上开发软件，配置太累了。