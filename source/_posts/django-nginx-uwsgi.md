---
title: django nginx uwsgi 配置
date: 2020-01-05 14:35:14
tags: [django, nginx, uwsgi, supervisor]
---

# 服务器配置，一般来说官网最可靠。

>官网的一般是最新版的，你在别的地方找到的配置可能用不了。

## 记录nginx与uwsig配置

- uwsgi 处理动态数据。`pip install uwsgi`安装。
- nginx 作为反向代理服务器，更安全、处理static文件效率更高。

### uwsgi 配置

>主要是能执行wsgi.py文件即可，socket本地要与nginx对应即可

```
[uwsgi]

base=/home/heart/Documents/server/vuedjango
socket=127.0.0.1:8000
chdir=%(base)
wsgi-file=vuedjango/wsgi.py  # 主要 !important
processes=4
threads=2
pythonhome=/usr/local/bin/python3
logto=%(base)/logs/uwsgi.log
```

启动`uwsgi uwsgi.ini`，[访问](http://127.0.0.1:8000)，访问成功后可关闭`ctrl+c`。

### nginx 配置

#### 局部配置 nginx.conf，绝对路径，监听80或443端口一起

>/home/heart/Documents/server/vuedjango/nginx.conf

```
server {
    listen      80;
    server_name _;
    access_log /home/heart/Documents/server/vuedjango/logs/access.log;
    error_log /home/heart/Documents/server/vuedjango/logs/error.log;
    location / {
        include uwsgi_params;
        uwsgi_pass 127.0.0.1:8000;
    }
    location /static/ {
        alias /home/heart/Documents/server/vuedjango/static/;
        expires 30d;
    }
}
```

#### 全局配置，系统级别

>include匹配局部配置*.conf

```
user root;
worker_processes auto;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 768;
    use epoll;
}

http {

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
    # 访问日志
    access_log  /var/log/nginx/access.log  main;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    # server_tokens off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
    ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    include /home/heart/Documents/server/vuedjango/*conf;
}
```

## 启动服务

```bash
uwsgi uwsgi.ini
sudo nginx -s reload
# or sudo service nginx restart
```

>这时候不能直接访问8000端口，因为已经反向代理了，只能直接访问ip地址了。

## supervisor进程管理，支持python3

>install

`pip install supervisor`

```bash
# general
sudo echo_supervisord_conf > /etc/supervisord.conf
sudo vi /etc/supervisord.conf
```

>修改

```
...
[include]
files = /etc/supervisord.d/*.ini
```

>新建

`sudo vi /etc/supervisord.d/vuedjango.ini`

>program: 后面的vuedjango是你要识别的名字
```
[program:vuedjango]
command=uwsgi /home/heart/Documents/server/vuedjango/uwsgi.ini
autostart=true
autorestart=true
redirect_stderr=true

killasgroup=true 
```

```bash
# 停止 uwsgi uwsgi.ini 用supervisor来管理
sudo supervisorctl reload
sudo supervisorctl start vuedjango
sudo supervisorctl status
```

```bash
$ sudo supervisorctl stop vuedjango  # 无法停止
$ ps -aux | grep uwsgi
heart     3520  0.0  3.1 127824 32332 ?        Sl   16:45   0:00 uwsgi /home/heart/Documents/server/vuedjango/uwsgi.ini
heart     3521  0.0  2.9 126920 29908 ?        Sl   16:45   0:00 uwsgi /home/heart/Documents/server/vuedjango/uwsgi.ini
heart     3522  0.0  2.9 126920 29908 ?        Sl   16:45   0:00 uwsgi /home/heart/Documents/server/vuedjango/uwsgi.ini
heart     3628  0.0  0.0  11036   884 pts/1    S+   16:48   0:00 grep --color=auto --exclude-dir=.bzr --exclude-dir=CVS --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn uwsgi

$ killall uwsgi
```

## 无法停止的原因是开了4个线程, 增加 master = true 重新启动supervisor就可以啦。
```bash
# uwsgi.ini
processes = 4
master = true
```
