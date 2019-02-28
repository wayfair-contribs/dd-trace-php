FROM mediawiki

ARG DD_TRACE_VERSION=0.14.1

WORKDIR /tmp

ADD https://github.com/DataDog/dd-trace-php/releases/download/${DD_TRACE_VERSION}/datadog-php-tracer_${DD_TRACE_VERSION}-beta_amd64.deb datadog-php-tracer.deb
RUN dpkg -i datadog-php-tracer.deb

WORKDIR /var/www/html
