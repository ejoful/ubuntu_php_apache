From ubuntu:18.04

MAINTAINER ejoful <ejoful@gmail.com>

# 安装最新的软件
RUN apt update && apt -y upgrade

# 添加ondrej/php PPA存储库，它有最新的PHP构建包
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php

# 安装最新的软件
RUN apt update && apt -y upgrade

# docker ubuntu 不选时区 https://blog.csdn.net/taiyangdao/article/details/80512997
# 1. 设置tzdata的前端类型（通过环境变量）
RUN export DEBIAN_FRONTEND=noninteractive
# 2. 安装tzdata软件包
RUN apt install -y tzdata
# 3. 建立到期望的时区的链接，设置时区为Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 4. 重新配置tzdata软件包，使得时区设置生效
RUN dpkg-reconfigure -f noninteractive tzdata

# 安装 Apache2
RUN apt install -y apache2


# 安装 PHP7.4
RUN apt install -y \
php7.4 \
php7.4-apcu \
php7.4-curl \
php7.4-dev \
php7.4-gd \
php7.4-fpm \
php7.4-imagick \
php7.4-intl \
php7.4-mbstring \
php7.4-memcached \
php7.4-mongodb \
php-pear \
php7.4-pdo \
php7.4-pdo-sqlite \
php7.4-pdo-mysql \
php7.4-pdo-pgsql \
php7.4-redis


# get php.ini file path
RUN php_ini_path=$(php -i | grep /.+/php.ini -Eo)


EXPOSE 80




