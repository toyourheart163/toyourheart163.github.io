---
title: vue-admin-template
date: 2019-12-16 00:27:04
categories: IT
tags: [vue]
---

# 由于vue-element-admin加载太久

更换成vue-admin-template

## 记录vue-admin-template使用问题

如果路由不加#号，就要重新登陆
>改写了后台登陆，不用重新登陆了. 不明白每次都要从后台获取用户信息。还要再改。2019-12-23

## 我想重用vue-admin-template，于是使用了`cp -r vue-admin-template vadmin`

>写于：2019-12-24

跳到[可行方案](#可行方案)
复制后得到提示.

### 错误提示1

```sh
cp: vue-admin-template/node_modules/.bin/not-in-publish: No such file or directory
...
```

为什么会这样?

运行`cd vadmin & npm run dev`

然后得到下面的错误

### 错误提示2

```sh
...
internal/modules/cjs/loader.js:775
    throw err;
    ^

Error: Cannot find module '../package.json'
Require stack:
...
sh: vue-cli-service: command not found
npm ERR! code ELIFECYCLE
npm ERR! syscall spawn
npm ERR! file sh
npm ERR! errno ENOENT
npm ERR! vue-element-admin@4.2.1 dev: `vue-cli-service serve`
npm ERR! spawn ENOENT
npm ERR!
npm ERR! Failed at the vue-element-admin@4.2.1 dev script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.
...
```

我就删除掉node_modules，从别的项目复制node_modules，也不行

于是上网找答案

只要

1. `rm -r node_modules`
2. `npm i`

但是这需要重新联网下载，而且我的手机流量只有几个G，于是我又找了npm离线安装方法

### 处理方法

#### 第一类，Registry 代理。
#### 第二类，npm install替代。

上面离线安装方法全部失败。
不小心直接`npm i`浪费了很多流量，第三种都不想试了

#### 第三类离线安装方法，node_modules作为缓存目录。

这个方案的思路是，不使用.npm缓存，而是使用项目的node_modules目录作为缓存。

    Freight
    npmbox

跳过。。。

试了下`npm install -offline` & `yarn install -offline`都无法解决

于是又去看vue-cli文档，没什么，又去看webpack的文档，也没有答案。

折腾了一天。

然后又看了看 [错误提示1](#错误提示1)
感觉是不是复制出了问题。然后看了看文件创建时间，是**今天**!!!

diff 一下看看有什么不同

`diff vadmin vue-admin-template`

找不到有什么不同:(

#### 可行方案

想到之前学到的netcat, 试着用netcat完整拷贝文件

终端窗口1，接收文件
1. `nc -l 6666 | tar -zxvf -`

终端窗口2，发送文件

1. `tar -zcvf - vue-admin-template | pv | nc localhost 6666`

>中间的`| pv |` 用来看复制进度的, 好像要安装一个软件来的，如果没有可以删除

终端窗口1

```sh
cd vue-admin-template
npm run dev
```

:smile:终于成功了

我想我可以自己做一个npm离线安装:)

又试着只拷贝node_modules文件夹，It work.

>写着这篇的时候，VS Code 又在后台自动下载了，我明明已经关了。又不见了我100M的流量

### 如果忘记url组成可以在浏览器的控制台输入`location`

## 更新日志

### 2019-12-23

#### 写了博客Timeline
#### 修改点击tag标签转到对应的Timeline
#### 增加三层评论
#### 博客页面增加全屏功能

### 2019-12-24

#### 去掉与博客不相关的组件与路由

### 2019-12-27

#### deploy to heroku

### 2019-12-30

#### feature: add github corner
