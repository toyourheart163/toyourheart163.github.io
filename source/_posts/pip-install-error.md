---
title: pip install error
date: 2020-05-30 09:45:33
tags: [debug, pip]
---

### pip install debug

```bash
➜   py setup.py sdist && py setup.py install
usage: setup.py [-h] [-f FILENAME] [-s seconds] [-c cmd]
setup.py: error: unrecognized arguments: sdist
➜   py setup.py install
usage: setup.py [-h] [-f FILENAME] [-s seconds] [-c cmd]
setup.py: error: unrecognized arguments: install
```

>原因是文件 __init__.py 中的 argparse 的命令拦截了setup.py

### 解决方案

```python
# 把 parser.add_argument 放在函数中
def main():
    parser.add_argument('-f', '--filename', required=False)
```


