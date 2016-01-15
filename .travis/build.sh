#!/bin/bash

set -ev

TAG="$REPOSITORY/$PROJECT-$ARCH"
TAGSPECIFIER="$VERSION-$VARIANT${CUSTOM:+-$CUSTOM}"

case "$CUSTOM" in
    ssl )
        docker pull   "$REPOSITORY/$PROJECT-$ARCH:$VERSION-$VARIANT"
        docker tag -f "$REPOSITORY/$PROJECT-$ARCH:$VERSION-$VARIANT" "$PROJECT:$VERSION-$VARIANT"

        [ -d "contrib/ssl/$VARIANT" ] || exit 1

        docker build -t "$TAG:$TAGSPECIFIER" "contrib/ssl/$VARIANT"
        ;;
    * )
        docker pull   "$REPOSITORY/php-$ARCH:5.6-$VARIANT"
        docker tag -f "$REPOSITORY/php-$ARCH:5.6-$VARIANT" "php:5.6-$VARIANT"

        docker build -t "$TAG:$TAGSPECIFIER" "$PROJECT/$VERSION/$VARIANT"
        ;;
esac

docker run --rm "$TAG:$TAGSPECIFIER" cat version.php
