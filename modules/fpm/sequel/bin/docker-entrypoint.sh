#!/usr/bin/env bash

set -e
set -o pipefail

exec docker-cloud.sh "$@"
