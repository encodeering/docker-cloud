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

case "$CUSTOM" in
    ssl )
        docker-pull "$DOCKER_IMAGE" "$PROJECT:$VARIANT"

        [ -d "owncloud-ssl/$VARIANT" ] || exit 1

        docker build -t "$DOCKER_IMAGE-$CUSTOM" "owncloud-ssl/$VARIANT"

        docker run --rm "$DOCKER_IMAGE-$CUSTOM" cat version.php
        ;;
    * )
        docker-pull "$REPOSITORY/php-$ARCH:$VARIANTVERSION-$VARIANT" "php:$VARIANT"

        patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < "patch/$SEMANTIC/$VARIANT/Dockerfile.patch"

        docker build -t "$DOCKER_IMAGE" --build-arg OWNCLOUD_VERSION="$VERSION" "$PROJECT/$SEMANTIC/$VARIANT"

        docker run --rm "$DOCKER_IMAGE" cat version.php
        ;;
esac

