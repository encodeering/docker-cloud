#!/bin/bash

set -ev

TAG="$REPOSITORY/$PROJECT-$ARCH"
TAGSPECIFIER="$VERSION-$VARIANT"

docker pull   "$REPOSITORY/php-$ARCH:5.6-$VARIANT"
docker tag -f "$REPOSITORY/php-$ARCH:5.6-$VARIANT" "php:5.6-$VARIANT"

docker build -t "$TAG:$TAGSPECIFIER" "$PROJECT/$VERSION/$VARIANT"

docker run --rm "$TAG:$TAGSPECIFIER" cat version.php
