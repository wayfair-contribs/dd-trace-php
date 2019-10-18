FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
      software-properties-common build-essential \
      vim curl supervisor wget libcurl4-openssl-dev \
      apache2 nginx
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y \
      libapache2-mod-php5.6 php5.6-fpm php5.6-cli php5.6-curl php5.6-dev \
      libapache2-mod-php7.0 php7.0-fpm php7.0-cli php7.0-curl php7.0-dev \
      libapache2-mod-php7.1 php7.1-fpm php7.1-cli php7.1-curl php7.1-dev \
      libapache2-mod-php7.2 php7.2-fpm php7.2-cli php7.2-curl php7.2-dev \
      libapache2-mod-php7.3 php7.3-fpm php7.3-cli php7.3-curl php7.3-dev \
    && apt-get clean

RUN mkdir /run/php
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN printf "\ndaemonize = no\n" | tee -a \
    /etc/php/5.6/fpm/php-fpm.conf \
    /etc/php/7.0/fpm/php-fpm.conf \
    /etc/php/7.1/fpm/php-fpm.conf \
    /etc/php/7.2/fpm/php-fpm.conf \
    /etc/php/7.3/fpm/php-fpm.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ddtrace-test.php /var/www/html/
COPY nginx-default-site /etc/nginx/sites-available/default

CMD ["/usr/bin/supervisord"]
