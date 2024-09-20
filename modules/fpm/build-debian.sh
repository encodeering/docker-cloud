#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:8.2-debian-fpm" "php:8.2-fpm-bookworm"

docker-build -t "cloud:fpm" "$PROJECT/${VERSION%%.*}/fpm"
docker-build --suffix sequel sequel
