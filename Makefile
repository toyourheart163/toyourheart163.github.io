init:
	rm -rf .git
	git init
	git add .
	git commit -m "init"
	git checkout -b hacker
	git remote add origin git@github.com:toyourheart163/toyourheart163.github.io.git
	git push origin hacker
d:
	hexo cl -g 
	hexo d

go:
	make init
	make d