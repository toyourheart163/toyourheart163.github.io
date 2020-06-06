---
title: 已经会python学c语言基础
date: 2020-06-06 10:41:07
tags: [clang]
---


## 如果会 python 了再去看 c 语言教程，那么可以略过很多地方

### C 语言基础总结

### 最简单的 c 程序, 没有输出. 用一个称手的兵器（编辑器）配上语法检查的, 输入

```c
int main() {
}
```

### 需要输出的

```c main.c
#include <stdio.h>  // 增加输入输出包

int main() {
  printf("OK");  // 语句后面加 `;`
}
```

### 编译与执行

```bash
gcc main.c  # 或者 cc main.c  # 编译 
./a.out  # 执行, 需要有权限的话就 `chmod a+x a.out` 增加执行权
gcc main.c && ./a.out  # 编译执行一起来
gcc -o hello main.c hello.c  # 多文件编译
# 如果想修改完后自动执行怎么办？我做了个命令行工具，如果你用 python，安装
pip install seeing
# 自动执行
seeing -f main.c
```

### 注释

```c
/* 多行注释 */
// 单行注释， 跟 javascript 一样
```

### 综合

```c
#include <stdio.h>

#define char nothin[20] "to your heart"  // 全局变量，宏

int main() {
    int a;  // 先定义类型
    a = 666;  // 后赋值
    printf("%d", a);  // 格式化打印

    float b = 537.767;  // 定义为浮点型，同时赋值
    printf("%.2f", b);

    char c[20] = "akfjdsl;a";  // 记得字符要用双引号
    puts(c);  // puts 可以自动换行，但是不能格式化

    // 指针，是指在内存中的地址变量
    int *p;  // 定义指针变量名
    int in[2] = {3, 9};
    p = in;  // 指向in
    printf("%p %p %p\n", p, &in, &in[0]);  // 指针地址是数组头的地址

    char *cc;
    char ccc[5] = "bingo";
    cc = ccc;
    printf("%p %p\n", cc, &(ccc[0]));

    int i;
    int list[SIZE] = {1,3,5,8,9};
    for (i=0; i<SIZE; i++) {
        printf("%d ", list[i]);
    }
    i = 0;
    while (i<SIZE) {
        printf("%d ", list[i]);
        i++;
    }
}
```

### struct union

```c
struct Person {
    char *name;
    int age
};

    struct person p1;
    p1.name = "lisa";
    p1.age = 18;

    union u_tag {
      int ival;
      float fval;
      char *sval;
    } u;
```

### 内存管理

```c
// 不要申请超大内存空间
char s[1024*1024*1024];  // 
```

### 文件操作

```c
    /*
    FILE *me;
    me = fopen("file.txt", "r");
    fgetc
    fputc
    fgets
    fputs
    fread
    fwrite  // 二进制时用？
    fclose(me);
    */
    FILE *me;
    char *filename = "file.txt";
    me = fopen(filename, "w");
    fprintf(me, "ABCJFDKSIE");
    fputc('\n', me);
    fclose(me);
    me = fopen(filename, "r");
    char res = EOF;
    while ((res = fgetc(me)) != EOF) {
        printf("%c", res);
    }

    rewind(me);  // 指针移到文件最前面
    char str[1024];
    fgets(str, 9, me);
    printf("\n%s\n", str);
    fclose(me);
```

### 系统自带库的使用

```c
#include <string.h>  // 字符串相关
#include <ctype.h>  // 判断单个字符类型
#include <math.h>

/*
strlen
isascii
*/
```

### 第三方库

>看了3本基础书都没有


### 拓展阅读

1. Ben Klemens：21st Century C——C Tips from the New School@2012 
