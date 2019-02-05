#!/bin/sh

dpkg -ui/build_src/build/packages/*.deb
php -m | grep ddtrace
