#!/bin/bash

set -ev

BRANCH=${BRANCH##master}
BRANCH=${BRANCH:+-${BRANCH}}
TAG="$REPOSITORY/$PROJECT-$ARCH"
TAGSPECIFIER="$VERSION-$VARIANT$BRANCH${CUSTOM:+-$CUSTOM}"

case "$CUSTOM" in
    ssl )
        docker pull   "$REPOSITORY/$PROJECT-$ARCH:$VERSION-$VARIANT$BRANCH"
        docker tag -f "$REPOSITORY/$PROJECT-$ARCH:$VERSION-$VARIANT$BRANCH" "$PROJECT:$VERSION-$VARIANT"

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
