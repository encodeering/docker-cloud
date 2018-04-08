FROM       cloud:fpm

MAINTAINER Michael Clausen <encodeering@gmail.com>

RUN        apt-get update                    \
 &&        apt-get install -y busybox-static \
 &&        rm -rf /var/lib/apt/lists/*

COPY       bin       /usr/local/bin
COPY       php/*.ini /usr/local/etc/php/conf.d/

RUN        chmod +x /usr/local/bin/*.sh
