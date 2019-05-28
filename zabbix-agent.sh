#!/bin/bash
# red 7
rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm

yum-config-manager --enable rhel-7-server-optional-rpms

yum -y install zabbix-agent

systemctl enable zabbix-agent

sed -i "s/Hostname=Zabbix server/Hostname=`dmidecode -s system-serial-number`/" /etc/zabbix/zabbix_agentd.conf

sed -i 's/Server=127.0.0.1/Server=zabbix-server.listenrobot.com/' /etc/zabbix/zabbix_agentd.conf

sed -i 's/ServerActive=127.0.0.1//' /etc/zabbix/zabbix_agentd.conf

cp zabbix_agentd.d /etc/zabbix/ -rf
cp scripts /etc/zabbix/ -rf

systemctl start zabbix-agent
