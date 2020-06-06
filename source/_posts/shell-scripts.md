---
title: shell-scripts
date: 2020-02-18 19:13:54
tags: shell
---

## 鸟哥的linux私房菜，学习

## shell script learning

>Tips: shell 不要用于大数据计算，效率低

### 易错点

```bash
# 数值运算:简单的加减乘除
total=$((3*6))

# 判断
# 2个 = 号时，用`bash script.sh`（因为`sh script.sh`无法识别）
# `sh script.sh`只能用一个 = 号 
[ "$HOME" == "$MAIL" ]

# 注释要另写一行，不要写在表达式后面
```

### if 结束语反过来fi
```bash
read -p "input Y/N: " yn

if [ "$yn" == "y" -o "$yn" == "Y" ]; then
	echo "yes"
elif [ "$yn" == "n" -o "$yn" == "N" ]; then
	echo "no"
else
	echo "else"
fi
```

### case 结束语倒装esac

```bash
case "$1" in
	"hello")
		echo "hello"
		;;
	"")
		echo "nothing"
		;;
	*)
		echo "else"
		;;
esac
```

### 循环

#### while

```bash
s=0
i=0
while [ "$i" != "100" ]
do
	i=$(($i+1))
	s=$(($s+$i))
done
echo "sum 1...100 is ===> $s"
```

#### until

```bash
until [ "$yn" == "yes" -o "$yn" == "YES" ]
do
	read -p "Please input yes/YES to stop this program: " yn
done
echo "OK! you input the correct answer."
```

#### for

```bash
for animal in dog cat elephant
do
	echo $animal
done
```

#### for two

```bash
read -p "Please input a number, I will count for 1+2+...+your_input: " nu
s=0
for (( i=1; i<=$nu; i=i+1 ))
do
	s=$(($s+$i))
done
echo "The result of '1+2+3+...+$nu' is ==> $s"
```

### shell script 的追踪 debug

`sh [-nvx] scripts.sh`

选项不参数:
-n :丌要执行 script，仅查询语法的问题;
-v :再执行 sccript 前，先将 scripts 的内容输出刡屏幕上;
-x :将使用刡的 script 内容显示刡屏幕上，这是很有用的参数!

### 函数

```bash
function printit() {
	# 加上 -n 可以丌断行继续在同一行显示
	echo -n "Your choice is "
}
printit; echo "yes"
```
