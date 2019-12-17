---
title: Django 数据分析
date: 2019-11-21 02:04:09
tags: [django, rest_framework, api, python]
categories: python
---

# django 统计功能

:smile:

## views.py

```python
# views.py

"""
年统计，月统计，分类统计, 假数据
faker data aggregate or annotate.
annotate 得到 queryset （数据集合）
aggregate 得到统计结果
"""
import random
from datetime import datetime

from faker import Faker
from django.db.models import Count, Avg, Sum, Max, Min
from django.http import JsonResponse

from api.models import Trade

# 生成假数据
names = ['iPhone', 'iPad', 'Mac', 'iPod', 'app']
faker = Faker()

def faker_price():
    return round(random.random()*1000 * random.random() * random.random(), 2)

for i in range(9999):
    created_at=faker.date_time_ad(start_datetime=datetime(2017, 1, 1))
    Trade.objects.create(name=random.choice(names), price=faker_price(), created_at=created_at)

def trade_list(request):
    """
    年统计，月统计，分类统计
    """
    # 年统计
    trades1 = Trade.objects.extra(select={'created_at': "strftime('%Y', created_at)"}).values('created_at', 'name').annotate(count=Count('id'))
    """
    统计结果
    Out[12]: <QuerySet [{'created_at': '2017', 'name': 'Mac', 'count': 699}, {'created_at': '2018', 'name': 'Mac', 'count': 640}...
    """

    # 月统计
    trades2 = Trade.objects.extra(select={'created_at': "strftime('%Y-%m', created_at)"}).values('created_at').annotate(count=Count('id'))

    # 分类（field: name）统计之和
    trades3 = Trade.objects.values('name').aggregate(Sum('price'))
    return JsonResponse({
        'code': 200
        'data': {
            'res_year': list(trades1),
            'res_month': list(trades2),
            'res_price_sum': trades3,
        }
    })
```

## models.py

```python
# models.py
from django.db import models

class Trade(models.Model):
    """
    订单的模型
    """
    name = models.CharField(max_length=70, default='iPad')
    price = models.DecimalField(max_digits=8, decimal_places=2)
    created_at = models.DateTimeField()

    def __str__(self):
        return self.name
```