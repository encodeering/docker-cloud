FROM       cloud:fpm

MAINTAINER Michael Clausen <encodeering@gmail.com>

RUN        apt-get update                    \
 &&        apt-get install -y busybox-static \
 &&        rm -rf /var/lib/apt/lists/*

RUN        mv /usr/local/bin/docker-entrypoint.sh  /usr/local/bin/docker-cloud.sh \
 ||        mv /entrypoint.sh                       /usr/local/bin/docker-cloud.sh

RUN        rm /cron.sh || true

COPY       bin       /usr/local/bin
COPY       php/*.ini /usr/local/etc/php/conf.d/

RUN        chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD        ["php-fpm"]
