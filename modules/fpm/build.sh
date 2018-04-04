#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:7.0-$BASE-$VARIANT" "php:7.0-$VARIANT" "php:7.1-$VARIANT"

docker-build -t "cloud:$VARIANT" "$PROJECT/$VERSION/$VARIANT"
docker-build --suffix sequel sequel

docker-verify                 cat version.php
docker-verify --suffix sequel cat version.php
