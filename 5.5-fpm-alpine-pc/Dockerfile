FROM nalscher/php:5.5-fpm-alpine

ENV PUID 1000
ENV GUID 1000 

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

RUN apk update && \
    apk add --no-cache shadow icu-dev g++ autoconf openssl-dev make pcre pcre-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    pecl install mongodb-1.1.9

RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini

RUN echo '[Date]\ndate.timezone = "UTC"' > /usr/local/etc/php/conf.d/timezone.ini

RUN groupmod -g $GUID www-data
RUN usermod -u $PUID  www-data