# 麦可乐的博客

## 这里麦可乐用Hexo的Next主题生成的博客

## 用Makefile自动部署博客
```
$ make deploy
```

```
# 部署脚本的内容
say:
    echo 输入make deplay生成与部署
deploy:
	hexo cl -g 
	hexo d
d:
	make deploy
init:
	rm -rf .git
	git init
	git add .
	git commit -m "init"
	git checkout -b hacker
	git remote add origin git@github.com:toyourheart163/toyourheart163.github.io.git
	git push origin hacker
go:
	make init
	make deploy
```