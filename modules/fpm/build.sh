#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:7.2-$BASE-$VARIANT" "php:7.2-$VARIANT" "php:7.2-$VARIANT-stretch"

docker-build -t "cloud:$VARIANT" "$PROJECT/$VERSION/$VARIANT"
docker-build --suffix sequel sequel

case "$PROJECT" in
  owncloud)
    docker-verify                 cat version.php
    docker-verify --suffix sequel cat version.php
    ;;
  nextcloud)
    docker-verify                 cat /usr/src/nextcloud/version.php
    docker-verify --suffix sequel cat /usr/src/nextcloud/version.php
    ;;
esac
