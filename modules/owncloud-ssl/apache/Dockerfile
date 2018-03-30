FROM       owncloud:apache

MAINTAINER Michael Clausen <encodeering@gmail.com>

WORKDIR    /etc/apache2

RUN        find conf-enabled   -name '*.conf' -exec basename {} \; | xargs -r a2disconf \
 &&        find sites-enabled  -name '*.conf' -exec basename {} \; | xargs -r a2dissite \
 &&        find conf-available  ! -name docker-php.conf -type f -delete                 \
 &&        find sites-available                         -type f -delete

COPY       php/docker-owncloud-php.ini /usr/local/etc/php/conf.d/

COPY       apache/vconf/*.conf conf-available/
COPY       apache/vhost/*.conf sites-available/

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

RUN        sed -i -e '/exec/i\source /etc/apache2/envvars'                                                  /usr/local/bin/docker-entrypoint.sh \
 &&        sed -i -e '/chown -R/a\        find /var/www/html ! -perm 750 -a -type d -exec chmod 750 {} \\;' /usr/local/bin/docker-entrypoint.sh \
 &&        sed -i -e '/chown -R/a\        find /var/www/html ! -perm 640 -a -type f -exec chmod 640 {} \\;' /usr/local/bin/docker-entrypoint.sh

EXPOSE     443

WORKDIR    /var/www/html
