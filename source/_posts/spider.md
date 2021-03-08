---
title: spider 爬虫与反爬
date: 2020-06-06 23:07:07
tags: [scrapy, requests]
---

## google 发家的工具

### 方法

>获取信息方法、反爬方法

1. 获取信息
  - html、css、js、svg
  - json
  - 图片
  - 音频
  - 视频
  - 其他文档
2. 解析信息
  - 文本
    - xpath
    - css
    - re
    - nltk 自然语言处理，机器学习
  - 图像
    - PIL
    - opencv
    - OCR 光学识别
    - 机器学习
  - 语音
    - google 的语音识别  
  - 视频
    - opencv
    - ffmpeg
    - 机器学习
3. 存储信息
  - 文件
    - html
    - json
    - csv
  - 数据库，数据仓库
    - 关系数据库
      - Mysql、Postgesql
    - 非关系数据库
      - MongoDB
4. 展示信息
  - 前端展示
    - 可视化
5. 工具箱
  - Scrapy
  - Pyspider
  - 浏览器插件
  - 其他软件

### 反爬方法

- robot.txt
- nginx 过滤请求头 python 
- 具体请求头过滤
- ip 过滤
  - geoip
- 字体
- 行为验证码
  - 滑动
  - 转动
  - 点触
  - 文字
  - 诗词
  - 计算结果
  - 图像识别
  - 九宫图
- 风险防控
- 设备绑定
- 短信，帐号绑定
- 带有效时间的，签名
- 加密证书
- 混淆
- 使用极验第三代
- 使用 google captcha
- 浏览器指纹
- 识别无头浏览器
- 使用 graphql 如 twitter 使用的那样
- Ajax
- 假数据
- 频率限制
- 分页限制
- 法律警告
- GFW

### 绕过方法

>可能需要法律咨询

- 忽略 robot.txt
- 频率限制
- google cache or other cache
- 改 header 随机 user-agent
  - 尝试改为手机版
  - mitmproxy 修改 response header
- 改 ip
  - 爬取代理网站的代理. 不稳定
  - 4G 手机切换飞行模式
  - 购买拨号 ip
  - tor 代理
  - scrapyhub 的代理 crawlera
  - heroku 代理 maintenance on/off 改 ip
- 获取字体文件，一一对应
- 使用 Chrome 控制台
- 图像识别
  - 九宫图 => 像素对比
  - OCR
  - 模拟人工轨迹
  - 使用人工
  - 机器识别，神经网络训练
- 跟网站管理员申请访问权限

### 二进制转中文

```python
response = requests.get(url="https://google.com")
response.content.decode('utf-8')  # 二进制转中文
```

### urllib 使用

```python
from urllib.parse import unquote, quote, urlencode

quote(url)
unquote(url)
person = {'name': 'li'}
urlencode(person)
```
