#!/usr/bin/env python2
#-*- coding:utf-8 -*-
import sys
import requests
import logging

# logger = logging.getLogger()

logger = logging.getLogger('mylogger')
logger.setLevel(logging.DEBUG)

# Create Handler
# 定义log目录
log_name = '/usr/lib/zabbix/alertscripts/chuanglan_status.log'
c_handler = logging.StreamHandler()
f_handler = logging.FileHandler(log_name)

# Create formatters and add it to handlers
c_format = logging.Formatter('%(name)s:%(levelname)s:%(message)s')
f_format = logging.Formatter('%(asctime)s:%(name)s:%(levelname)s:%(message)s')
c_handler.setFormatter(c_format)
f_handler.setFormatter(f_format)

# Add handlers to the logger
logger.addHandler(c_handler)
logger.addHandler(f_handler)

# 修改为您的API账号
account = "N6303216"
# 修改为您的API密码
password = "CQE13gIove4511"
# 创蓝发送短信接口URL
url = "http://smssh1.253.com/msg/send/json"
# 修改为您要发送的手机号,zabbix传过来的第一个参数
phone = sys.argv[1]
# 设置您要发送的内容其中“【】”中括号为运营商签名符号，多签名内容前置添加提交,zabbix传过来的第一个参数
msg = "【zabbix】" + sys.argv[2]

headers = {"Content-type": "application/json"}

data = {"account": account, "password": password, "phone": phone, "msg": msg, "report": "true"}

ret = requests.post(url=url, json=data)
if ret.status_code == 200:
    logger.info(ret.text)
else:
    logger.error(ret.text)