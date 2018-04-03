#!/usr/bin/env bash

set -e
set -o pipefail

if [ `find ${APACHE_CONFDIR}/sites-enabled ! -name "${VHOST}.*" -type l | wc -l` -gt 0 ]; then
    echo "error: a vhost has already been enabled - VHOST envvar should be treated as effectively immutable"
    exit 1
fi

a2ensite ${VHOST}

exec docker-cloud.sh "$@"
