From ubuntu:latest

MAINTAINER sky

RUN sed -i'' 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list
RUN apt -y update

# 
RUN apt install -y software-properties-common
RUN add-apt-repository -r ppa:fossfreedom/byzanz
RUN apt update

# docker ubuntu 不选时区 https://blog.csdn.net/taiyangdao/article/details/80512997
# 1. 设置tzdata的前端类型（通过环境变量）
RUN export DEBIAN_FRONTEND=noninteractive
# 2. 安装tzdata软件包
RUN apt install -y tzdata
# 3. 建立到期望的时区的链接，设置时区为Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 4. 重新配置tzdata软件包，使得时区设置生效
RUN dpkg-reconfigure -f noninteractive tzdata

# Install Apache
RUN apt install -y apache2

# Set timezone
RUN echo "Asia/Shanghai" | tee /etc/timezone

# Install PHP
RUN apt install --fix-missing -y \
php \
libapache2-mod-php \
php-intl \
php-pdo \
php-pdo-sqlite \
php-pdo-mysql \
php-pdo-pgsql \
php-dev \
php-common \
php-gd \
php-mbstring \
php-apcu \
php-imagick \
php-redis \
php-curl \
php-memcached \
php-imagick \
php-cli \
php-opcache \
php-mongodb \
php-pear \
php-fpm

# get php.ini file path
RUN php_ini_path=$(php -i | grep /.+/php.ini -Eo)

EXPOSE 80
