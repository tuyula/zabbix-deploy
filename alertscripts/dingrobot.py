#!/usr/bin/python
# -*- coding: utf-8 -*-
# Author: daniel

import requests
import json
import sys


def msg(msg, robot_id):
    headers = {'Content-Type': 'application/json;charset=utf-8'}
    api_url = "https://oapi.dingtalk.com/robot/send?access_token={}".format(robot_id)
    json_text= {
        "msgtype": "text",
        "text": {
            "content": msg
        }
    }
    print requests.post(api_url,json.dumps(json_text),headers=headers).content

if __name__ == '__main__':
    robot_id = "12a576322c221daff9d834b9a5dbb70087533aada8614b3c3ce20bbf15a106c3"
    msg(sys.argv[1], robot_id)