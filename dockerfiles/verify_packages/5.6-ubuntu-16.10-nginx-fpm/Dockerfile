FROM php:5.6-fpm

RUN apt-get update \
        && apt-get -y install \
            net-tools \
            nginx \
            procps \
            supervisor

CMD /usr/bin/dpkg -i /datadog/datadog-php-*.deb && supervisord -n
