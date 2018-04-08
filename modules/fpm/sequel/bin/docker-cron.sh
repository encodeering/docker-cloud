#!/usr/bin/env bash

set -e

mkdir -p /var/spool/cron/crontabs/

echo "${1:-*/15 * * * *} `which php` -f /var/www/html/cron.php" | tee /var/spool/cron/crontabs/www-data

exec busybox crond -f -l 8 -L /dev/stdout
