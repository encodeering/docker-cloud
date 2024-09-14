## Automatically created docker image for nextcloud

[![Build Status](https://travis-ci.org/encodeering/docker-cloud.svg?branch=master)](https://travis-ci.org/encodeering/docker-cloud)
[![Build Status](https://semaphoreci.com/api/v1/encodeering/docker-cloud/branches/master/shields_badge.svg)](https://semaphoreci.com/encodeering/docker-cloud)

### Docker Nextcloud  ([Origin](https://github.com/nextcloud/docker))

- https://hub.docker.com/r/encodeering/nextcloud-armhf/

    ```docker pull encodeering/nextcloud-armhf:16.0-debian-fpm```  
    ```docker pull encodeering/nextcloud-armhf:16.0-debian-fpm-sequel```  
    ```docker pull encodeering/nextcloud-armhf:16.0-alpine-nginx```  
    ```docker pull encodeering/nextcloud-armhf:17.0-debian-fpm```  
    ```docker pull encodeering/nextcloud-armhf:17.0-debian-fpm-sequel```  
    ```docker pull encodeering/nextcloud-armhf:17.0-alpine-nginx```  
    ```docker pull encodeering/nextcloud-armhf:18.0-debian-fpm```  
    ```docker pull encodeering/nextcloud-armhf:18.0-debian-fpm-sequel```  
    ```docker pull encodeering/nextcloud-armhf:18.0-alpine-nginx```

- https://hub.docker.com/r/encodeering/nextcloud-amd64/

    ```docker pull encodeering/nextcloud-amd64:16.0-debian-fpm```  
    ```docker pull encodeering/nextcloud-amd64:16.0-debian-fpm-sequel```  
    ```docker pull encodeering/nextcloud-amd64:16.0-alpine-nginx```  
    ```docker pull encodeering/nextcloud-amd64:17.0-debian-fpm```  
    ```docker pull encodeering/nextcloud-amd64:17.0-debian-fpm-sequel```  
    ```docker pull encodeering/nextcloud-amd64:17.0-alpine-nginx```  
    ```docker pull encodeering/nextcloud-amd64:18.0-debian-fpm```  
    ```docker pull encodeering/nextcloud-amd64:18.0-debian-fpm-sequel```  
    ```docker pull encodeering/nextcloud-amd64:18.0-alpine-nginx```


### Configuration

Nginx sequel image inherits two environment configurations

1. VHOST_CUSTOMIZATION: "true"

   If set, creates a `nginx` directory within `/var/www/html` with proper permissions and includes any nginx configuration.

2. VHOST_CANONICAL: "www-only" | "www-off"

   If set, creates an additional server block and either redirects from www to non-www, or non-www to www

### Setup

1. Install [docker](https://docs.docker.com/install/) and [docker-compose](https://docs.docker.com/compose/install)
1. Download [nginx](examples/nginx/docker-compose.yml) docker-compose.yml file
1. Setup ddns and configure port forwarding on your router
1. Run `export EMAIL=your@email.com`
1. Run `export DOMAIN=ddns.domain.com`
1. Run `export SECRET=secret` [default]
1. Run `export PROVIDER=nextcloud` [default]
1. Run `export VERSION=15.0` [default]
1. Run `export ARCH=armhf` [default]
1. Run `docker-compose up`
1. Open browser and check connectivity
1. Finalize installation with postgres as database. Use `postgres` as host, `postgres` as user and `$SECRET` as password
1. Optionally run `docker-compose exec -u www-data cloud php occ config:system:set trusted_domains 0 --value=$DOMAIN`

You can also create a [`.env`](https://docs.docker.com/compose/environment-variables/#the-env-file) file on the same directory level of the used `docker-compose.yml` and put all `export`s inside.

All examples use local volumes. So, please adjust the [driver](https://docs.docker.com/engine/extend/legacy_plugins/#volume-plugins) to your needs.
