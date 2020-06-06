---
title: Make docker image smeller than 30X
date: 2020-03-04 20:41:03
tags: [docker, Ops]
---

>Docker image is very big. Use docker-slim make is 30X smeller.

## install docker-slim

### download

[docker-slim](https://github.com/docker-slim/docker-slim)

```bash
unzip dist_mac.zip
chmod +rx dist_mac/docker-slim*
mv dist_mac/docker-slim /usr/local/bin/
mkdir /tmp/docker-slim-state
cp dist_mac/docker-slim-sensor /tmp/docker-slim-state/
```

## Use

```bash
docker pull python
docker-slim build --http-probe=false python
```

>(Before: 689MB => After: 17MB) It's smeller 40X.

```bash
$ docker images | grep -n "python"
3:python.slim                latest              9d74b2d5f44f        6 hours ago         17MB
9:python                     3.6                 07d72c0beb99        23 months ago       689MB
```
