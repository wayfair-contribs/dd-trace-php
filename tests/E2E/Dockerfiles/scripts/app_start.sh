#!/usr/bin/env bash

set -e

# Installing package
cd /packages
dpkg -i datadog-php-tracer_*_amd64.deb
cd -

php -d memory_limit=-1 /usr/bin/composer update
