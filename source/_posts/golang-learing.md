---
title: golang learing
date: 2020-06-18 15:13:01
tags: [golang]
---

### go help

```bash
go help gopath
go env | grep GOPROXY
```

### golang 配置 enviroment config

#### go env 查看配置

- GOPATH 用来查找依赖的包，下载的或者自己的
- GOROOT go 系统安装的东西的位置
- GOBIN 命令行位置 与 PATH 配合 
- GOPROXY 镜像

```bash
go env -w GOBIN=$PATH:$PWD/bin  # 设置
go env -u GOBIN  # -u unset 删除此配置
```
```bash
# ~/.zshrc  or ~/.bashrc or ~/.profile
# 将 GOPATH 设置为新的 window 目录
export GOPATH=$PWD
# 如果设置了 GOPATH=$PWD 当前目录就不能用 go.mod
# go.mod 是模块的意思，就像 python 中的 requirements.txt 包含了包管理需要的包
# go get {url} 时会下载 go.mod 中的包
# go mod vender  用 vender 替换 src 位置 因为以前没有官方包管理工具
```

```go go.mod
module github.com/mikele/hello

go 1.14
```

### 从 github 下载模块

```bash
go get https://github.com/toyourheart163/ohmygost
```

### 编写自己的模块

>google golang module

```bash
cd src/github.com/toyourheart163/ohmygost
mkdir music && cd music
vi music.go
```

### 编写模块内容

```go
module music

func Songs() {}
func Albums() {}
```

### 引用模块

```go
package main

import (
  _ 'github.com/toyourheart163/ohmygost'
)

func main() {
  music.Songs()
  music.Albums()
}
```
