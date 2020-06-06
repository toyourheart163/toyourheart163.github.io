---
title: drf debug
date: 2020-04-25 03:18:20
tags: [drf, django, debug]
---

## get a bug

```python
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': (
        'rest_framework.pagination.PageNumberPagination',),
    ...

---
bug
---
    self._paginator = self.pagination_class()
TypeError: 'list' object is not callable
[25/Apr/2020 03:21:51] "GET /api/v1/projects/ HTTP/1.1" 500 16449
``` 

## fix bug

```python
        'rest_framework.pagination.PageNumberPagination',),
							^^^
```

## Why i get this bug

>I use pylint to check the codes, settings module is too long in a line more than 79 bit. so i cut down.
