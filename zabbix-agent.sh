#!/bin/bash
# red 7
# delete pre rpm
pre_rpm=`rpm -qa|grep zabbix-agent`
for item in $pre_rpm
do
    if [[ $item = "zabbix-agent-4.0.8-1.el7.x86_64" ]];then
        rpm -e $item
        yum clean all
    fi;
done

yum erase -y zabbix-agent

rm -rf /etc/zabbix/scripts
rm -rf /etc/zabbix/scripts/zabbix_agentd.d

if cat /etc/redhat-release|grep 7\. > /dev/null;then
    rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
elif cat /etc/redhat-release|grep 6\. > /dev/null;then
    rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/6/x86_64/zabbix-agent-4.0.1-1.el6.x86_64.rpm
else
    echo "Dont find Linux Version info:" `cat /etc/redhat-release`
fi

if grep 10\.28\.25\.25 /etc/resolv.conf > /dev/null;then
    echo "nameserver 10.28.25.25" >> /etc/resolv.conf
fi

if grep 10\.28\.12\.12 /etc/resolv.conf > /dev/null;then
    echo "nameserver 10.28.12.12" >> /etc/resolv.conf
fi


yum-config-manager --enable rhel-7-server-optional-rpms

yum -y install zabbix-agent, dmidecode

systemctl enable zabbix-agent

sed -i "s/Hostname=Zabbix server/Hostname=`dmidecode -s system-serial-number`/" /etc/zabbix/zabbix_agentd.conf

sed -i 's/Server=127.0.0.1/Server=zabbix-passive.listenrobot.com/' /etc/zabbix/zabbix_agentd.conf

sed -i 's/ServerActive=127.0.0.1//' /etc/zabbix/zabbix_agentd.conf

cp zabbix_agentd.d /etc/zabbix/ -rf
cp scripts /etc/zabbix/ -rf
chown zabbix:zabbix /etc/zabbix/ -R
chown zabbix:zabbix /var/log/zabbix/ -R

# install env
yum -y install epel-release
yum -y install python-pip

# install request package
pip install --upgrade setuptools
pip install --upgrade pip

if pip -V|grep 2.6 > /dev/null;then
    echo "The python version is 2.6"
else
    pip install simplejson
fi

# delete some file
if [[ -a /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf ]];then
    rm /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf
fi;
if [[ -a /etc/zabbix/zabbix_agentd.d/UserParameter.conf ]];then
    rm /etc/zabbix/zabbix_agentd.d/UserParameter.conf
fi;


if cat /etc/redhat-release|grep 7\. > /dev/null;then
    systemctl restart zabbix-agent
elif cat /etc/redhat-release|grep 6\. > /dev/null;then
    service zabbix-agent start
else
    echo "Dont find Linux Version info:" `cat /etc/redhat-release`
fi
