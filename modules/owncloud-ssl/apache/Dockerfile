FROM       owncloud:apache

MAINTAINER Michael Clausen <encodeering@gmail.com>

ARG        DEFAULT_SHA=fdd55ad7cf9b495bccdd8465f37bbfe1577068b24abae0f3d934b6a1d1d29331
ARG        DEFAULT_SSL_SHA=d073d698c49535c619cbcc5d0bf0c9b1b1370ff1afde2d618a6a178bc013a985

WORKDIR    /etc/apache2

RUN        find conf-enabled -name '*.conf' -exec basename {} \; \
  |        xargs -r a2disconf                                    \
 &&                 a2enconf docker-php

RUN        a2dissite          000-default \
 &&        mv sites-available/000-default.conf sites-available/default.conf

RUN        echo "$DEFAULT_SHA sites-available/default.conf"         | sha256sum -c - \
 &&        echo "$DEFAULT_SSL_SHA sites-available/default-ssl.conf" | sha256sum -c -

COPY       php/docker-owncloud-php.ini /usr/local/etc/php/conf.d/

COPY       apache/vhost/default.conf     sites-available/default.conf
COPY       apache/vhost/default-ssl.conf sites-available/default-ssl.conf

RUN        sed -i -e '$a ServerTokens Prod'   apache2.conf \
 &&        sed -i -e '$a ServerSignature Off' apache2.conf

RUN        a2enmod ssl      \
 &&        a2enmod headers  \
 &&        a2enmod deflate  \
 &&        a2enmod expires  \
 &&        a2ensite default \
 &&        a2ensite default-ssl

RUN        sed -i -e '/exec/i\source /etc/apache2/envvars'                                                  /usr/local/bin/docker-entrypoint.sh \
 &&        sed -i -e '/chown -R/a\        find /var/www/html ! -perm 750 -a -type d -exec chmod 750 {} \\;' /usr/local/bin/docker-entrypoint.sh \
 &&        sed -i -e '/chown -R/a\        find /var/www/html ! -perm 640 -a -type f -exec chmod 640 {} \\;' /usr/local/bin/docker-entrypoint.sh

EXPOSE     443

WORKDIR    /var/www/html
