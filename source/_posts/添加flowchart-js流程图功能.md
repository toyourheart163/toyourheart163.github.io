---
title: 博客添加flowchart.js流程图功能
date: 2019-12-03 02:02:29
tags: [flowchart, 流程图]
---

## 添加流程图功能

[flowchart](https://github.com/bubkoo/hexo-filter-flowchart)

```sh
npm install -s hexo-filter-flowchart
```

st是变量名，->是指向

## 代码块后缀是flow

<kbd>\`</kbd><kbd>\`</kbd><kbd>\`</kbd>flow
````sh
\`\``flow # 太难了
st=>start: Start|past:>http://toyourheart163.github.io[blank]
e=>end: down:>http://localhost:4000
op1=>operation: learn flowchart

st->op1->e
```
````

## 效果展示

```flow # too hard to show.
st=>start: Start|past:>http://toyourheart163.github.io[blank]
e=>end: down:>http://localhost:4000
op1=>operation: learn flowchart

st->op1->e
```

## 似乎这个库对flow的解析还不够好，无法展示flow的代码块

### python代码块示例

\```python
1+2
\```

### 示例2

````
```python
import this
```
````
