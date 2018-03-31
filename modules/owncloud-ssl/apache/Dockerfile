FROM       owncloud:apache

MAINTAINER Michael Clausen <encodeering@gmail.com>

EXPOSE     80
EXPOSE     443

WORKDIR    /etc/apache2

RUN        find conf-enabled   -name '*.conf' -exec basename {} \; | xargs -r a2disconf \
 &&        find sites-enabled  -name '*.conf' -exec basename {} \; | xargs -r a2dissite \
 &&        find conf-available  ! -name docker-php.conf -type f -delete                 \
 &&        find sites-available                         -type f -delete

RUN        mv /usr/local/bin/docker-entrypoint.sh  /usr/local/bin/docker-owncloud.sh

COPY       bin/docker-entrypoint.sh    /usr/local/bin/
COPY       php/docker-owncloud-php.ini /usr/local/etc/php/conf.d/

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
                    security   \
 &&        a2ensite default    \
                    default-ssl

RUN        sed -i -e '/exec/i\source /etc/apache2/envvars'                                                  /usr/local/bin/docker-owncloud.sh \
 &&        sed -i -e '/chown -R/a\        find /var/www/html ! -perm 750 -a -type d -exec chmod 750 {} \\;' /usr/local/bin/docker-owncloud.sh \
 &&        sed -i -e '/chown -R/a\        find /var/www/html ! -perm 640 -a -type f -exec chmod 640 {} \\;' /usr/local/bin/docker-owncloud.sh

WORKDIR    /var/www/html
