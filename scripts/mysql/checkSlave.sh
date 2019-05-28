#!/bin/bash
#

###
## grant process,replication client  on *.* to zabbix@'127.0.0.1' identified by 'ls@2018#1'; ##
###

source /etc/profile

MYSQL_USER='zabbix'
MYSQL_PWD='ls@2018#1'
MYSQL_HOST='127.0.0.1'
MYSQL_PORT='3306'

MYSQL_CONN="/usr/local/mysql/bin/mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_PORT}"

check_stat() {
        slave_stat=(`${MYSQL_CONN} -e "show slave status\G" 2>/dev/null | egrep "Running:" | awk -F":" '{print $NF}'`)
        if [ ${slave_stat[0]} == "Yes" -a ${slave_stat[1]} == "Yes" ];then
                echo "1"
        else
                echo "0"
                exit 17
        fi

}

check_behind() {
	slave_behind=`${MYSQL_CONN} -e "show slave status\G" 2>/dev/null | egrep "Behind" | awk -F":" '{print $NF}'`
	echo ${slave_behind}
}

case $1 in
status)
	check_stat
	;;
behind)
	check_behind
	;;
*)
	echo "Usage : $0 status|behind ."
	;;
esac

