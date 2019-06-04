FROM centos:latest
MAINTAINER "taoyu"

# 3. 安装环境
COPY ../requirements.txt /tmp

RUN set -ex \
    && yum -y install epel-release \
    && yum -y install python-pip \
    && pip install -r /tmp/requirements.txt \
    && yum clean all \
    && rm -rf /var/cache/yum/* \
    && rm -rf /opt/luna.tar.gz \
    && rm -rf /var/cache/yum/* \
    && rm -rf ~/.cache/pip \
    && rm -rf /opt/linux-amd64.tar.gz
