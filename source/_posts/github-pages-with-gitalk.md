---
layout:     post
title:      Add Gitalk to github pages
subtitle:   添加gitalk到github-pages遇到的问题
date:       2019-11-01 22:39:10
author:     TY
header-img: img/
catalog: true
tags: [jekyll, Hexo, Gitalk, github-pages, zsh, AutoJump]
---

# 花了几小时终于搞定`Gitalk`了

[Hexo](#用Hexo来搭建github-pages博客)
## 遇到的问题

1. Error: Not Found. 

    *没有*填对`repo`等对应的信息
    ```
    clientID: "xxxxxxxxxxxx"  # 用自己的
    clientSecret: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # 用自己的
    repo: "toyourheart163.github.io"
    owner: "toyourheart163"
    admin: ['toyourheart163']
    id: location.pathname 
    ```

2. Error: Validation Failed

    `location.href`要改成`location.pathname`
    ```
    ！因为issue里的标题不能超过50字符？
    ```

    - 或者可以改成md5，这样就不超过50个字符啦。可以参考Hexo里的代码, 在`themes/next/scripts/helpers/engine.js`文件里面

    ```
    id: '{{ gitalk_md5(page.path) }}',
    ```

    ```javascript
    // 引用crypto库
    <script src="https://cdn.jsdelivr.net/npm/crypto-js@3.1.9-1/crypto-js.js"></script>
    <script>
    function gitalk_md5 (str) {
        return crypto.createHash('md5').update(str).digest('hex');
    }
    </script>
    ...
    id: '{{ gitalk_md5(location.pathname) }}',
    ...
    ```

## 用Hexo来搭建github-pages博客

1. 安装hexo `npm i -g hexo-cli`
2. `hexo init gh-pages & cd gh-pages`
3. 安装 `next` 主题

    `git clone https://github.com/theme-next/hexo-theme-next themes/next`
4. 切换主题, 在主目录下的 `_config.yml` 看到`theme: landscape` 修改成`theme: next`
```
# 需要部署到github时修改deploy接着的内容，repo改成自己的，分支是master
deploy:
    type: git
    repo: git@github.com:toyourheart163/toyourheart163.github.io.git
```
5. 配置`Gitalk`, 在 `next` 文件夹下的`_config.yml`

    1. 如果没有github app，点[这里](https://github.com/settings/applications/new)注册一个, 申请方法参考[here](https://largecats.github.io/2019/06/17/Build-blog/)
    ```
    gitalk:
      enable: true
      github_id: 'toyourheart163'
      repo: "toyourheart163.github.io"
      client_id: 'xxxxxxxxxxxxxxxxxxxx'
      client_secret: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      admin_user: 'toyourheart163'
      distraction_free_mode: true
    ```

    2. 修改文件 /theme/next/layout/_partial/comments.swig
    ```
    修改在最后一行的{%- endif %} 为下面代码
    {%- elseif page.gitalk.enable %}
    <div id="gitalk-container"></div>     
    {%- endif %}
    ```
6. `hexo clean & hexo deploy`
7. `git init`时要先删除`themes/next`里的`.git`文件夹


### 安装hexo后可能遇到的问题
`$ WARN  No layout: index.html`
使用第3-4步解决

**如果一天中写了2篇github pages，发现排序与写作顺序不一样，在date里加个时间**

`date:       2019-11-01 22:39:10`

## 在终端zsh配置2个git帐号

>[Git多用户配置](https://www.jianshu.com/p/b02645fff791)

生成第2个ssh密钥，**不要覆盖以前的`id_rsa`**
```
$ cd ~/.ssh
$ ssh-keygen -t rsa -C "at home" 
Enter file in which to save the key: (/Users/xxx/.ssh/id_rsa): 
# 输入保存密钥的文件名，比如`id_rsa3`
...
```

### 配置重点

    cd ~/.ssh
    vim config 
    Host github.com  
    User toyourheart163 # 重点
    Hostname github.com
    IdentityFile ~/.ssh/id_rsa

    Host github.com
    User maikele  # 重点
    Hostname github.com
    IdentityFile ~/.ssh/id_rsa3  #访问github的SSH KEY

