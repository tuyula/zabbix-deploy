#!/bin/bash
# ubuntu 18.04
##### delete pre rpm #####


##### install new rpm #####
wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+bionic_all.deb
dpkg -i zabbix-release_4.0-2+bionic_all.deb
apt update
apt -y install zabbix-agent

##### add dns #####
if ! grep 10\.28\.25\.25 /etc/resolv.conf > /dev/null;then
    echo "nameserver 10.28.25.25" >> /etc/resolv.conf
fi

if ! grep 10\.28\.12\.12 /etc/resolv.conf > /dev/null;then
    echo "nameserver 10.28.12.12" >> /etc/resolv.conf
fi

##### start install agent #####
systemctl enable zabbix-agent

sed -i "s/Hostname=Zabbix server/Hostname=`dmidecode -s system-serial-number`/" /etc/zabbix/zabbix_agentd.conf
sed -i 's/Server=127.0.0.1/Server=zabbix-passive.listenrobot.com/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1//' /etc/zabbix/zabbix_agentd.conf

cp zabbix_agentd.d /etc/zabbix/ -rf
cp scripts /etc/zabbix/ -rf
chown zabbix:zabbix /etc/zabbix/ -R
chown zabbix:zabbix /var/log/zabbix/ -R

##### install env #####
apt -y install python-pip

##### install request package #####
pip install --upgrade setuptools
pip install --upgrade pip

if pip -V|grep 2.6 > /dev/null;then
    echo "The python version is 2.6"
else
    pip install simplejson
fi

##### delete some file #####
if [[ -a /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf ]];then
    rm /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf
fi;
if [[ -a /etc/zabbix/zabbix_agentd.d/UserParameter.conf ]];then
    rm /etc/zabbix/zabbix_agentd.d/UserParameter.conf
fi;


if cat /etc/redhat-release|grep 7\. > /dev/null;then
    systemctl restart zabbix-agent
elif cat /etc/redhat-release|grep 6\. > /dev/null;then
    service zabbix-agent restart
else
    echo "Dont find Linux Version info:" `cat /etc/redhat-release`
fi
