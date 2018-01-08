#!/usr/bin/env bash

set -e

import com.encodeering.docker.config
import com.encodeering.docker.docker

docker-pull "$REPOSITORY/php-$ARCH:7.0-$BASE-$VARIANT" "php:7.0-$VARIANT"

docker build -t "$DOCKER_IMAGE" -t "$PROJECT:$VARIANT" "$PROJECT/$VERSION/$VARIANT"
docker build -t "$DOCKER_IMAGE-ssl" "owncloud-ssl/$VARIANT"

docker run --rm "$DOCKER_IMAGE"     cat version.php
docker run --rm "$DOCKER_IMAGE-ssl" cat version.php
