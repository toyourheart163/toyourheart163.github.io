---
title: git-flow-github-flow进阶
date: 2019-12-30 18:11:41
tags: git
---

# git 进阶

以下内容学习自IBM：曹志。感谢他的通俗易懂的解释。

## 一、基础简介

### 系统级别配置

`git config --system -l`

### ignore 忽略文件

<details id="markdown"><summary>展开/关闭</summary>
|模式|示例|
|---|---|
|完整路径|db.sqlite3|
|/path|只匹配当前这个文件 /config.py|
|path|当前目录与递归目录的文件 *.pyc|
|path/|只匹配目录及其文件|
|带*|所有满足的条件 *.zip|
|带**|满足前后路径 Dev/**/dev.conf|
|!path|不忽略|

## 二、基础配置

### git 的三种状态

```git
Modified(已修改)
Staged(已暂存)  add/rm/mv  可用git add/rm/mv 保存到暂存区
Commited(已提交)
```

### 三个工作区域

```git
工作区
暂存区
仓库目录 .git
```

>暂存区 可以任意修改，保证提交历史的干净。另一个作用是开分支不想提交时git stash暂存和未暂存的保存到缓冲栈。比如我`git checkout -`把一点未暂存的丢失了

### fetch 与 pull 区别

pull 相当于 git fetch & git merge
就是先获取再合并。

## 四、撤消

revert 回滚
提交一个commit覆盖前面的。要写一下原因。

恢复到某个commit

```git
git log  # find id
git reset --hard commit_id # 暴力操作。
```

## 五、分支管理策略

### git flow

发布多个版本

```
master 生命周期长，项目开始就存在
dev 长
feature
hotfixed
releases
```

### github flow

发布单一版本 master

用pull request代码评审