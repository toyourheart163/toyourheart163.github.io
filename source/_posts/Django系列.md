---
layout:     post
title:      Django 系列一
subtitle:   rest_framework api
date:       2019-07-27
categories: python
tags:
    - Django
    - RESTful api
    - rest_framework
    - python
---

## 生成 restful api

```shell
$ # do alias
$ django-admin startproject rest
$ dapp api  # python3 manage.py startapp
$ drun  # python3 manage.py runserver
```

1. [rest/settings.py](#settings)
2. [api/models.py](#models)
    * [sql](#sql)
3. [api/serializers.py](#serializers)
4. [api/viewsets.py](#viewsets)
5. [rest/routers.py](#routers)
6. [rest/urls.py](#urls)
7. [use httpie](#httpie)

### settings

```python
INSTALLED_APPS = [
    ...
    'api',
    'rest_framework',
}
```
### models

```python
class Blog(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=100, blank=True, default='')
    descriptions = models.TextField()
```

### sql

```shell
$ alias pm='python manage'
$ pm makemigrations
$ pm migrate
$ pm createsuperuser  # username=user password=pwd
```

### serializers

```python
from rest_framework import serializers

from .models import Blog


class BlogSerializer(serializers.ModelSerializer):
    class Meta:
        model = Blog
        fields = '__all__'
```

### viewsets

```python
from rest_framework import viewsets

from .models import Blog
from .serializers import BlogSerializer


class BlogViewSet(viewsets.ModelViewSet):
    queryset = Blog.objects.all()
    serializer_class = BlogSerializer
```

### routers

```python
from rest_framework import routers

from api.viewsets import BlogViewSet

router = routers.DefaultRouter()
router.register(r'blogs', BlogViewSet)
```

### urls

```python
...
- from django.urls import path
+ from django.urls import path, include

from .routers import router

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
]
```

### httpie, a modern curl

```shell
$ pip install httpie
$ http -a user:pwd POST :8000/api/blogs/ title=test descriptions=go
$ http :8000/api/
```