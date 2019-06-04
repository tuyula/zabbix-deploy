FROM harbor.listenrobot.com/ops/centos:zabbix
MAINTAINER "taoyu"

# 1. 创建一个/usr/lib/zabbix的volume
VOLUME /usr/lib/zabbix

# 2. 将alertscripts放入/usr/lib/zabbix/alertscripts
COPY ./alertscripts /usr/lib/zabbix/alertscripts

