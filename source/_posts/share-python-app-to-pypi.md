---
title: share python app to pypi
date: 2020-02-22 13:20:13
tags: [python, pypi, package]
---

# 分发安装包到pypi

1. 注册[Pypi](https://pypi.org/account/register)  https://pypi.org/account/register
2. 验证邮箱
3. [生成token](https://pypi.org/manage/account/token/)
4. 复制token到~/.pypirc文件大概像下面那样

    [pypi]
      username = `__token__`
      password = `your_token`

5. `pip search $thiscn` 看看有没有和你的python包同名

## 安装包的文件

```
├── .gitignore
├── LICENSE
├── README.md
├── setup.py
├── thiscn
│   └── __init__.py
```

### setup.py

```python
import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="thiscn", # Replace with your own username
    version="0.0.2",
    author="Mikele",
    author_email="blive200@gmail.com",
    description="The zen of Python, English and Chinese.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/toyourheart163/thiscn",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)
```

>setup.py需要修改的内容有: name, version, author, email, description, url

### LICENSE和.gitignore可以在github生成项目时生成

.gitignore 选择 python
LICENSE 可以选择MIT

### `thiscn/__init__.py`

简单的项目可以直接在`__init__.py`写源代码

## 安装twine

```bash
pip install twine
```

## 生成package压缩包

```bash
python setup.py sdist
```

## 分享到Pypi

```bash
twine upload dist/*
```
