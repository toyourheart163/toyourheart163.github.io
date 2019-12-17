---
title: django-rest-framework-extensions
date: 2019-12-17 10:21:51
categories: python
tags: [DRY, Django, rest_framework, python]
---

## API搜索过滤问题

用rest_framework 搜索的时候只有包含的选项, 无法排除关键字, 用django里的filter又要改写别的东西，于是到rest_framework文档查询到了[django-url-filter](https://github.com/miki725/django-url-filter)
**如果能做到像twitter那样排除使用`- csdn`就好了**

### rest_framework 的搜索能力
```
'^': 'istartswith',
'=': 'iexact',
'@': 'search',
'$': 'iregex',
```

### django-url-filter使用方法

在settings.py里配置, 以及viewset要配置
```
# setting.py
'DEFAULT_FILTER_BACKENDS': [
    'url_filter.integrations.drf.DjangoFilterBackend',
]
```

需要添加`filter_fields = '__all__'`才能使用
```
# viewsets.py
class BlogViewSet(ModelViewSet):
    ...
    filter_fields = '__all__'
```

### 示例

```
# get user with id 5
example.com/users/?id=5

# get user with id either 5, 10 or 15
example.com/users/?id__in=5,10,15

# get user with id between 5 and 10
example.com/users/?id__range=5,10

# get user with username "foo"
example.com/users/?username=foo

# get user with username containing case insensitive "foo"
example.com/users/?username__icontains=foo

# get user where username does NOT contain "foo"
example.com/users/?username__icontains!=foo

# get user who joined in 2015 as per user profile
example.com/users/?profile__joined__year=2015

# get user who joined in between 2010 and 2015 as per user profile
example.com/users/?profile__joined__range=2010-01-01,2015-12-31

# get user who joined in after 2010 as per user profile
example.com/users/?profile__joined__gt=2010-01-01
```
