#coding:utf-8
import json
import commands

(status, output) = commands.getstatusoutput('''netstat -tlnp|grep 'weed'|grep -v 18080|awk '{print $4}'|awk -F':' '{print $(NF)}'|sort -u''')
outputs = output.split('\n')
ports = []
for port in outputs:
    ports += [{'{#WEEDPORT}': port}]

print json.dumps({'data':ports},sort_keys=True,indent=4)
