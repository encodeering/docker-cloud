#!/usr/bin/env bash
# configuration
#   env.ARCH
#   env.PROJECT
#   env.VERSION
#   env.VARIANT
#   env.REPOSITORY

set -e

import com.encodeering.docker.config
import com.encodeering.docker.docker

SEMANTIC="${VERSION%.*}"

docker-pull "$REPOSITORY/php-$ARCH:$VARIANTVERSION-$BASE-$VARIANT" "php:$VARIANTVERSION-$VARIANT"

docker build -t "$DOCKER_IMAGE" -t "$PROJECT:$VARIANT" "$PROJECT/$SEMANTIC/$VARIANT"
docker build -t "$DOCKER_IMAGE-ssl" "owncloud-ssl/$VARIANT"

docker run --rm "$DOCKER_IMAGE"     cat version.php
docker run --rm "$DOCKER_IMAGE-ssl" cat version.php
