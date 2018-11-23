FROM alpine:latest AS breeze-php

LABEL maintainer="Vane Breeze OS"

ENV PHP_VERSION 7.2.12
ENV GPG_KEYS B1B4 4D8F 021E 4E2D 6021  E995 DC9F F8D3 EE5A F27F
ENV SHA d7cabdf4e51db38121daf0d494dc074743b24b6c79e592037eeedd731f1719dd

RUN addgroup -S nginx \
    && adduser -D -S -h /website -s /sbin/nologin -G nginx nginx \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN CONFIG="\
    --disable-debug \
    --disable-rpath \
    --enable-fpm \
    --with-fpm-user=nginx \
    --with-fpm-group=nginx \
    --with-fpm-acl \
    --with-libxml-dir \
    --with-openssl \
    --with-kerberos \
    --with-pcre-regex \
    --with-zlib \
    --enable-bcmath \
    --with-bz2 \
    --enable-calendar \
    --with-curl \
    --enable-dba \
    --with-enchant \
    --enable-exif \
    --disable-fileinfo \
    --with-pcre-dir \
    --enable-ftp \
    --with-gd \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir \
    --with-gettext \
    --with-gmp \
    --with-mhash \
    --enable-mbstring \
    --enable-mbregex \
    --with-mysqli \
    --enable-embedded-mysqli \
    --with-mysql-sock=/tmp/mysql.sock \
    --enable-pcntl \
    --with-pdo-mysql \
    --enable-session \
    --enable-shmop \
    --enable-soap \
    --enable-sockets \
    --enable-sysvsem \
    --enable-wddx \
    --with-xmlrpc \
    --enable-xml \
    --with-iconv-dir \
    --with-xsl \
    --enable-zip \
    --enable-mysqlnd \
    --without-pear \
    --enable-shared \
    --with-password-argon2 \
    " \
    && apk add --no-cache --virtual .build-deps \
    gnupg \
    ca-certificates \
    curl \
    tar \
    xz \
    libressl \
    autoconf \
    dpkg-dev \
    dpkg \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pkgconf \
    re2c \
    coreutils \
    acl-dev \
    libxml2-dev \
    bzip2-dev \
    curl-dev \
    libressl-dev \
    argon2-dev \
    libsodium-dev \
    sqlite-dev \
    enchant-dev \
    gd-dev \
    jpeg-dev \
    libpng-dev \
    libxpm-dev \
    freetype-dev \
    gmp-dev \
    libxslt-dev \
    && mkdir -p /usr/src \
    && cd /usr/src \
    && curl -fSL http://php.net/distributions/php-$PHP_VERSION.tar.gz -o php.tar.gz \
    && curl -fSL http://php.net/distributions/php-$PHP_VERSION.tar.gz.asc  -o php.tar.gz.asc \
    && echo "$SHA php.tar.gz" | sha256sum -c - \
    && export GNUPGHOME="$(mktemp -d)" \
    && for key in $GPG_KEYS; do gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; done \
    && gpg --batch --verify php.tar.gz.asc php.tar.gz \
    && command -v gpgconf > /dev/null && gpgconf --kill all \
    && rm -rf "$GNUPGHOME" \
    && apk del .fetch-deps \
    && tar -zxC /usr/src -f php.tar.gz \
    && rm php.tar.gz \
    && cd /usr/src/php-$PHP_VERSION \
    && ./configure $CONFIG \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && rm -rf /usr/src/php-$PHP_VERSION \
    && apk del .build-deps \
    && apk add --no-cache tzdata


# STOPSIGNAL SIGTERM

# CMD ["php-fpm"]