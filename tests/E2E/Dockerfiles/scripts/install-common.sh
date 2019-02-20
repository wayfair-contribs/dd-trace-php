#!/usr/bin/env bash

# Installing utility tools
apt install -y net-tools
apt install -y supervisor
apt install -y vim
apt install -y wget

# Installing composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php  --install-dir="/usr/bin" --filename=composer
php -r "unlink('composer-setup.php');"
composer self-update
