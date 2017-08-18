FROM nalscher/php:5.5-fpm-alpine

ENV PUID 1000
ENV GUID 1000

ENV APP_ROOT /var/www/html
ENV NR_VERSION newrelic-php5-7.4.0.198-linux-musl
ENV NR_INSTALL_SILENT true
ENV APP_DATETIME UTC
ENV APP_POST_SIZE 64M
ENV APP_MEMORY_LIMIT 256M

ENV APP_ENVIRONMENT production
ENV APP_DEPLOY_ENV production

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

RUN apk update && \
    apk add --no-cache shadow icu-dev g++ autoconf openssl-dev make pcre pcre-dev bash msttcorefonts-installer gnumeric libssh2-dev openssh-client && \
    docker-php-ext-configure intl && \
    docker-php-ext-configure opcache && \
    docker-php-ext-install intl opcache && \
    update-ms-fonts && \
    fc-cache -f && \
    pecl install mongodb-1.1.9 && \
    printf "\n" | pecl install apcu-4.0.11 && \
    printf "\n" | pecl install ssh2

RUN wget http://ffmpeg.gusari.org/static/64bit/ffmpeg.static.64bit.latest.tar.gz -O - | tar zxf - -C /usr/bin

RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini
RUN echo "extension=mongodb.so" > /usr/local/etc/php-fpm.d/mongodb.ini
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini
RUN echo "extension=apcu.so" > /usr/local/etc/php-fpm.d/apcu.ini
RUN echo "extension=ssh2.so" > /usr/local/etc/php/conf.d/ssh2.ini
RUN echo "extension=ssh2.so" > /usr/local/etc/php-fpm.d/ssh2.ini

RUN printf "[Date]\ndate.timezone = \"${APP_DATETIME}\"" > /usr/local/etc/php/conf.d/timezone.ini
RUN printf "[Date]\ndate.timezone = \"${APP_DATETIME}\"" > /usr/local/etc/php-fpm.d/timezone.ini

RUN printf "opcache.fast_shutdown = 0\nopcache.enable_cli = 0\nupload_max_filesize = ${APP_POST_SIZE}\npost_max_size = ${APP_POST_SIZE}\nmemory_limit = ${APP_MEMORY_LIMIT}" > /usr/local/etc/php/conf.d/z-pc.ini
RUN printf "opcache.fast_shutdown = 0\nopcache.enable_cli = 0\nupload_max_filesize = ${APP_POST_SIZE}\npost_max_size = ${APP_POST_SIZE}\nmemory_limit = ${APP_MEMORY_LIMIT}" > /usr/local/etc/php-fpm.d/z-pc.ini

RUN cd && \
    wget http://download.newrelic.com/php_agent/release/${NR_VERSION}.tar.gz && \
    gzip -dc ${NR_VERSION}.tar.gz  | tar xf - && \
    cd ${NR_VERSION} && \
    ./newrelic-install install

ADD start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/start.sh"]