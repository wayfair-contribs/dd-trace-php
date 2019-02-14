FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y software-properties-common
    && add-apt-repository ppa:ondrej/php
    && apt-get -y install \
        apache2 \
        net-tools \
        nginx \
        procps \
        php5.6 \
        php5.6-fpm \
        supervisor \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*

# CMD /usr/bin/dpkg -i /datadog/datadog-php-*.deb && supervisord -n
