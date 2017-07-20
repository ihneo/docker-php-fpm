FROM nalscher/php:5.5-fpm-alpine

RUN apk update && \
    apk add --no-cache icu-dev g++ autoconf openssl-dev make pcre-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    pecl install mongodb-1.1.9

RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini

RUN echo '[Date]\ndate.timezone = "UTC"' > /usr/local/etc/php/conf.d/timezone.ini
