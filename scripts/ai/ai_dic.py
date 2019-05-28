#!/bin/env python
import collections
import os
import sys
import datetime
from operator import methodcaller
import time
try:
    from os import scandir
except ImportError:
    from scandir import scandir

temp_dir = '/data/ai/var/log'
res1 = {}

# 获取uid:ai_num
def get_ai_info(dir):
    dir_entities = scandir(dir)
    dir_entities = sorted(dir_entities, key=methodcaller('inode'))

    cur_time = time.time()
    file_infos = []

    for dir_entity in dir_entities:
        path = dir_entity.path
        name = dir_entity.name
        timeSecond = os.path.getmtime(path)
#	print(timeTenSecod)
        if timeSecond >= (cur_time - int(sys.argv[1]) * 60):
            file_size = os.path.getsize(path)
            if file_size > 10 * 1024:
                file_infos.append((name, file_size))

    user_info =  {}
    for file_info in file_infos:
        #print(file_info)
        data_split_info = file_info[0].split("_")
        if len(data_split_info) < 4:
            #print("Opps, not many sperate")
            continue
        user_id = int(data_split_info[3])
        if not(user_id in user_info):
            user_info.setdefault(user_id, []).append(file_info)
        else:
            user_info[user_id].append(file_info)
    #print(user_info)
    #res2 = 0
    for key, value in user_info.items():
	#path1 = '/opt/zabbix/scripts/ai/'
	#path2 = path1 + str(key)
	res = int(len(value))
	res1[key] = res
   	#res2 = res2 + res
    print(res1)
    #user_input = int(sys.argv[1].strip())
    #print(res1[user_input])
    #print(len(user_info))
    #if len(user_info) is None:
#	print(0)
get_ai_info(temp_dir)
