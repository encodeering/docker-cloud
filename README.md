## Automatically created docker image for owncloud

[![Build Status](https://travis-ci.org/encodeering/docker-owncloud.svg?branch=master)](https://travis-ci.org/encodeering/docker-owncloud)

### Docker

```docker pull encodeering/owncloud-armhf```

- 8.2-apache, 8.2-apache-ssl
- https://hub.docker.com/r/encodeering/owncloud-armhf/

```docker pull encodeering/owncloud-amd64```

- 8.2-apache, 8.2-apache-ssl
- https://hub.docker.com/r/encodeering/owncloud-amd64/

### Modification

In addition to the offical build of the owncloud image we generate a custom SSL image, which derives from the official image, but modifies the following

- apache
 - [ssl, header, expiration](apache/apache/default-ssl.conf)
 - [php](apache/php/docker-owncloud-php.ini)
