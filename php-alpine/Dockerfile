FROM alpine:latest

ENV VERSION 7.2.12

RUN addgroup -g 82 -S nginx \
    && adduser -u 82 -D -S -h /website -s -G nginx nginx \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache \
    php7 \
    php7-fpm \
    php7-common \
    php7-calendar \
    php7-bz2 \
    php7-zip \
    php7-session \
    php7-curl \
    php7-imap \
    php7-soap \
    php7-openssl \
    php7-ctype \
    php7-mcrypt \
    php7-sodium \
    php7-exif \
    php7-gd \
    php7-fileinfo \
    php7-gmp \
    php7-bcmath \
    php7-iconv \
    php7-mbstring \
    php7-enchant \
    php7-json \
    php7-yaml \
    php7-xml \
    php7-dom \
    php7-xmlrpc \
    php7-simplexml \
    php7-xmlreader \
    php7-xmlwriter \
    php7-xsl \
    php7-redis \
    php7-mongodb \
    php7-mysqli \
    php7-mysqlnd \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-opcache \
    php7-xdebug

COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf

VOLUME /website /website

EXPOSE 9000

STOPSIGNAL SIGTERM

CMD [ "php-fpm7" ]