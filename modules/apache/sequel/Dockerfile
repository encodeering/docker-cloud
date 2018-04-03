FROM       cloud:apache

MAINTAINER Michael Clausen <encodeering@gmail.com>

EXPOSE     80
EXPOSE     443

ENV        VHOST=ssl-redirect

WORKDIR    /etc/apache2

RUN        find conf-enabled   -name '*.conf' -exec basename {} \; | xargs -r a2disconf \
 &&        find sites-enabled  -name '*.conf' -exec basename {} \; | xargs -r a2dissite \
 &&        find conf-available  ! -name docker-php.conf -type f -delete                 \
 &&        find sites-available                         -type f -delete                 \
 &&        rm ports.conf

RUN        mv /usr/local/bin/docker-entrypoint.sh  /usr/local/bin/docker-cloud.sh

COPY       bin/docker-entrypoint.sh    /usr/local/bin/
COPY       php/docker-php-cloud.ini    /usr/local/etc/php/conf.d/

COPY       apache/apache2.conf .
COPY       apache/vconf/*.conf conf-available/
COPY       apache/vhost/*.conf sites-available/
COPY       apache/vhost/conf   conf

RUN        chmod +x /usr/local/bin/docker-entrypoint.sh

RUN        a2enmod ssl         \
                   headers     \
                   deflate     \
                   expires     \
                   mime        \
 &&        a2enconf docker-php \
                    deflate    \
                    expires    \
                    mime       \
                    vhost      \
                    security

WORKDIR    /var/www/html
