#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:7.2-$BASE-$VARIANT" "php:7.2-$VARIANT"
docker-pull "$REPOSITORY/php-$ARCH:7.3-$BASE-$VARIANT" "php:7.3-$VARIANT-buster"

docker-build -t "cloud:$VARIANT" "$PROJECT/$VERSION/$VARIANT"
docker-build --suffix sequel sequel

check () {
    dup | contains "VersionString = '${VERSION}"
}

case "$PROJECT" in
  owncloud)
    docker-verify                 cat version.php | check
    docker-verify --suffix sequel cat version.php | check
    ;;
  nextcloud)
    docker-verify                 cat /usr/src/nextcloud/version.php | check
    docker-verify --suffix sequel cat /usr/src/nextcloud/version.php | check
    ;;
esac
