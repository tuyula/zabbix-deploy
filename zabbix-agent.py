import os
import platform

if __name__ == '__main__':
    sys_version = platform.linux_distribution()[0]

    if "CentOS" in sys_version:
        # positive model
        os.system('bash ./zabbix-agent.sh')
    elif "Ubuntu" in sys_version:
        os.system('bash ./zabbix-agent-ubuntu.sh')
    else:
        print("The Version dont Support {}".format(sys_version))