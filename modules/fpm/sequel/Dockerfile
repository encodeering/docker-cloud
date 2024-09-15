FROM       cloud:fpm

MAINTAINER Michael Clausen <encodeering@gmail.com>

COPY       php/*.ini ${PHP_INI_DIR}/conf.d/

RUN        ln -s    "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini"
