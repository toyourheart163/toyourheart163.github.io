---
title: pandas数据处理
date: 2020-01-08 21:17:39
tags: [pandas, data, analysis]
---

## 一开始不认识pandas，采用的是openpyxl库
- 好处是可以合并单元格，设置颜色，还可以隐藏某些列表。

>如何删除表格首尾几行？

|天下公司| |
|---|---|
|name|age|
|lisa| 18|
|nacy| 20|
|total|38|


```python
'''
删除表格首尾几行
'''
from openpyxl import load_workbook

wb = load_workbook('excel.xlsx')
ws = wb.active

def ws_remove_front_and_end_rows(ws):
    # 删除前1行注释
    ws.delete_rows(0,1)
    # 删除最后一行的统计
    ws.delete_rows(ws.max_row,ws.max_row)
    data = ws.values
    # 第二行作为列表名
    columns = next(data)[0:]
    df = pd.DataFrame(data, columns=columns)
    return df
```

## 总结一下pandas数据处理

```python
import pandas as pd
import numpy as np
```

### 读取文件

```python
# 读取excel文件的名叫sheet2工作表
filename = 'file.xlsx'
df = pd.read_excel(filename, sheet_name='sheet2')

# 读取多个工作表，合并成1个表格。
import xlrd as xl

def concat_sheets(filename)
    '''merge many sheets to one DataFrame'''
    wb = xl.open_workbook(filename)
    sheet_names = wb.sheet_names()  # 获取多个工作表名。
    xlsx = pd.ExcelFile(filename)
    ts = pd.DataFrame()
    for sheet_name in sheet_names:
        df = pd.read_excel(xlsx, sheet_name=sheet_name)
        ts = ts.append(df, ignore_index=True)
    return ts

# 读取文件编码为gb18030的csv
ts = pd.read_csv('file.csv', encoding='gb18030')
```

### 基本操作

```python
# 修改列名
df = df.rename(columns={'仓库': '仓库名称'})  

# 读取文件修改列的类型
df = pd.read_excel(filename, dtype={'外部编码': str, '外部sku': 'int32'})

# 合并，以左边的表格为准
res = pd.merge(ts, df, on=['外部编码', '外部sku'], how='left')

# 这个是什么操作
df.between_time('20180908', '20180909')

# 选择列、行
df.loc[:, ['货品编码', '货品名称']]
df = df[df['货品编码']==6971525990012]

# 重置索引
df.reset_index()

# 时间处理
pd.Timestamp('2018-10-23 16:49:13.700945')

# 改变一列的时间格式
df['时间'] = df['时间'].apply(lambda x: pd.Timestamp(x).strftime('%Y-%m-%d'))
df['时间'] = df['时间'].map(lambda x: x[:10])

# 某个月的最后一天
from calendar import monthrange
month_last_day = monthrange(year=2018, month=10)[1]  # 31

# 统计总和
df.groupby(['仓库名称', '货品id', '货品名称']).sum()

# 备注1列包含"村淘"2个字
df[df['备注'].str.contains('村淘')]

# 不包含，加了~
df[~df['备注'].str.contains('村淘')]
```

## 高级操作

```python
# 以index为时间，计算每段时间内的数据，3M代表3个月，3个月之和
df.resample('3M').sum()

# 负数变红，引起重视。
def color_negative_red(val):
    """
    Takes a scalar and returns a string with
    the css property `'color: red'` for negative
    strings, black otherwise.
    """
    color = 'red' if val < 0 else 'Blue'
    return 'color: %s' % color

def highlight_max(s):
    '''
    highlight the maximum in a Series yellow.
    '''
    is_max = s == s.max()
    return ['background-color: yellow' if v else '' for v in is_max]

# 链式操作，正数蓝色，负数红色，最大值黄色，一目了然。
df.style.applymap(color_negative_red).apply(highlight_max)

# 导出excel格式，并忽略索引列
df.to_excel("res.xlsx", index=False)

# 保存多个工作表到1个文件
xls = pd.ExcelWriter('file_write.xlsx')
df1.to_excel(xls, sheet_name='7月')
df2.to_excel(xls, sheet_name='8月')
xls.save()
```

## 实例演示
```python
'''
计算店铺消费超过500元的客户
'''
import os
import time

import pymongo
import pandas as pd

client = pymongo.MongoClient()
db = client.goods
tag = 'selled_order_list'
coll = db[tag]
# coll.find().count()
collection = db.max_500

def get_max_500_in_3_month(shop):
    '''从销售数据表1统计某3个月消费超过500元的客户，保存的max_500数据表'''
    # 从数据库获取数据，并且倒序
    results = coll.find({
        '店铺名称': shop
        }).sort('订单创建时间', pymongo.DESCENDING)  # .skip(100000).limit(100000)  # 降序
    datas = list(results)
    df = pd.DataFrame(datas)

    df['买家实际支付金额'] = df['买家实际支付金额'].astype('float')
    ts = df[['买家会员名', '买家实际支付金额', '订单状态', '订单创建时间']]

    # 不需要交易已关闭的
    ts = ts[ts['订单状态']!='交易关闭']
    ts = ts.drop(columns=['订单状态'])

    # 把index设置为时间，方便统计某个时间段的数据
    ts = ts.set_index('订单创建时间')
    # ts.describe()
    names = set(ts['买家会员名'])
    print(shop, '共有', len(names), '用户')

    def max_500(name):
        '''某3个月购买大于500元的客户'''
        tf = ts[ts['买家会员名']==name]
        tf = tf.sort_values('订单创建时间', ascending=False)
        s = tf.resample('3M').sum()
        s_max = s.max()['买家实际支付金额']
        tf_sum = tf.groupby('买家会员名').sum()['买家实际支付金额'][0]
        tf_mean = tf_sum / len(tf.index)
        if s_max >= 500:
            now = pd.Timestamp.now()
            user = {
                '旺旺': name,
                '3个月支付金额之和': s_max,
                '购买时间段': s.index[-1],
                '开始购买时间': tf.index[-1],
                '开始购买金额': tf['买家实际支付金额'][-1],
                '最后购买时间': tf.index[0],
                '最后购买金额': tf['买家实际支付金额'][0],
                '平均下单金额': round(tf_mean, 2),
                '下单总数': len(tf.index),
                '下单总金额': tf.groupby('买家会员名').sum()['买家实际支付金额'][0],
                '店名': shop,
                '更新时间': now
            }
            collection.insert_one(user)
    
    print(pd.Timestamp.now(), '开始插入数据库')
    for i, name in enumerate(list(names)):
        if i % 2000 == 0:
            print(pd.Timestamp.now(), '解析到=>第 ', i+1, ' 个用户')
            max_500(name)
        else:
            max_500(name)

    print(pd.Timestamp.now(), ' insert end')

if __name__=='__main__':
    get_max_500_in_3_month(shop='麦可乐的淘宝店')
```