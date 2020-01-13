---
title: appium-spider 爬取手机app抖音等, 配置
date: 2020-01-07 19:56:28
tags: [appium,python]
---

## apps scrapy 爬取记录

### 安装appium, **backup your app data, because it will clear your app data.**

>请备份你要测试的app的数据.

>请备份你要测试的app的数据.

>请备份你要测试的app的数据.

重要的事多说几遍。如果你的手机不是测试机，最好先备份。比如我首先用来测试的酷安，数据就被清空了。

```bash
# 在电脑上安装appium
# in pc
$ npm install -g appium  # 可能不支持旧版的安卓比如4.4的 
```

### 需要安装java和对应的sdk

```bash
brew install java 
```

#### 下载安装Android Studio 
[https://developer.android.com/studio](https://developer.android.com/studio)
安装后下载sdk[安装方法](https://cuiqingcai.com/5407.html)
我的安卓版本是9.1需要下载Android Api 28的Android SDK Platform 28	

- 配置ANDROID_HOME、JAVA_HOME变量

```bash
# ~/.zshrc 仅供参考, 替换用户名heart为你的。
export ANDROID_HOME=/Users/heart/Library/Android/sdk
export PATH=$ANDROID_HOME/sdk/tools:$PATH
export PATH=$ANDROID_HOME/sdk/platform-tools:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-10.0.1.jdk/Contents/Home
```

### 使用，我的测试机器是mac电脑

```bash
# 在电脑上查看已连接usb的手机
# in pc
$ adb devices -l  # windows可能是adb devices
SH12EPL03311           device usb:336592896X product:htc_bravo model:HTC_Desire device:bravo
9FK0219304005159       device usb:337641472X product:ELE-AL00 model:ELE_AL00 device:HWELE
```

可以看到有2台手机连接了电脑，记一下model的名字ELE_AL00, device的HWELE在adb shell会看到

>in android

open your app which want to test.
打开你想要测试的app

```bash
# in pc
$ adb shell
HWELE:/ $ 
```

### 手机上打开抖音，电脑输入下列命令

```bash
# pc输入dumpsys window windows | grep -E mCurrentFocus, window需要`mCurrentFocus`加引号
HWELE:/ $ dumpsys window windows | grep -E mCurrentFocus
  mCurrentFocus=Window{dc9f877 u0 com.ss.android.ugc.aweme/com.ss.android.ugc.aweme.main.MainActivity}
```

### 显示结果分析
  `com.ss.android.ugc.aweme`就是后面要用到的appPackage
`com.ss.android.ugc.aweme.main.MainActivity`的`.main.MainActivity`是后面要用到的appActivity

```json
{
  "platformName": "Android",
  "deviceName": "ELE_AL00",
  "appPackage": "com.ss.android.ugc.aweme",
  "appActivity": ".main.MainActivity"
}
```

>上面的json数据需要填入appium里面

### 分析结果

明显`appPackage` + `appActivity` = `com.ss.android.ugc.aweme.main.MainActivity`

$ 配置完毕



