FROM ubuntu:17.10

RUN apt-get update \
        && apt-get -y install \
            apache2 \
            apache2-dev \
            apt-transport-https \
            autoconf \
            bison \
            build-essential \
            ca-certificates \
            curl \
            git \
            libsqlite3-dev \
            libxml2-dev \
            lsb-release \
            re2c \
            software-properties-common \
            sqlite3

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update \
        && apt-get -y install \
            libapache2-mod-fastcgi \
            php5.6 \
            php5.6-fpm
RUN systemctl status php5.6-fpm

#RUN mkdir -p /usr/src
#WORKDIR /usr/src
#
#RUN git clone https://github.com/php/php-src.git
#WORKDIR /usr/src/php-src

#RUN ./buildconf
#RUN ./configure --with-config-file-scan-dir=/etc/php.d --with-config-file-path=/etc --with-fpm-user=www-data --with-fpm-group=www-data --enable-fpm
#RUN make
#RUN make make install

CMD bash
