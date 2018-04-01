#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/php-$ARCH:7.0-$BASE-$VARIANT" "php:7.0-$VARIANT"

docker-build "$PROJECT/$VERSION/$VARIANT"

docker-verify cat version.php
