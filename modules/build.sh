#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:7.0-$BASE-$VARIANT" "php:7.0-$VARIANT"

docker-build -t "$PROJECT:$VARIANT" "$PROJECT/$VERSION/$VARIANT"
docker-build --suffix ssl "owncloud-ssl/$VARIANT"

docker-verify              cat version.php
docker-verify --suffix ssl cat version.php
