#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

./build-${BASE}.sh

check () {
    dup | contains "VersionString = '${VERSION}"
}

docker-verify                 cat /usr/src/nextcloud/version.php | check
docker-verify --suffix sequel cat /usr/src/nextcloud/version.php | check
