#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:8.2-alpine-fpm" "php:8.2-fpm-alpine3.20"

docker-build -t "cloud:fpm" "$PROJECT/${VERSION%%.*}/fpm-alpine"
docker-build --suffix sequel sequel
