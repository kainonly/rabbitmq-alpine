FROM alpine:edge

ENV PHP_VERSION 7.3.0
ENV GPG_KEYS CBAF69F173A0FEA4B537F470D66C9593118BCCB6 F38252826ACD957EF380D39F2F7956BC5DA04B5D
ENV PHP_URL="https://secure.php.net/distributions/php-7.3.0.tar.gz" PHP_ASC_URL="https://secure.php.net/distributions/php-7.3.0.tar.gz.asc"
ENV PHP_SHA256="391bd0f91d9bdd01ab47ef9607bad8c65e35bc9bb098fb7777b2556e2c847b11" PHP_MD5=""
ENV PHPIZE_DEPS autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c

RUN set -x \
    && addgroup -g 82 -S nginx \
    && adduser -u 82 -D -S -G nginx nginx \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache --virtual .persistent-deps \ 
    ca-certificates \
    curl \
    tar \
    openssl \
    argon2 \
    argon2-libs \
    acl \
    libxml2 \
    bzip2 \
    libedit \
    libsodium \
    sqlite \
    enchant \
    gd \
    jpeg \
    libpng \
    libxpm \
    freetype \
    gmp \
    libxslt \
    libzip

RUN set -xe \
    && apk add --no-cache --virtual .fetch-deps gnupg \
    && mkdir -p /usr/src && cd /usr/src \
    && curl -fSL "${PHP_URL}" -o php.tar.gz \
    && if [ -n "${PHP_SHA256}" ]; then \
    echo "${PHP_SHA256} *php.tar.gz" | sha256sum -c -; \
    fi; if [ -n "${PHP_MD5}" ]; then \
    echo "${PHP_MD5} *php.tar.gz" | md5sum -c -; \
    fi; if [ -n "${PHP_ASC_URL}" ]; then \
    curl -fSL "${PHP_ASC_URL}" -o php.tar.gz.asc; \
    export GNUPGHOME="$(mktemp -d)"; \
    for key in $GPG_KEYS; do \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
    done; \
    gpg --batch --verify php.tar.gz.asc php.tar.gz; \
    command -v gpgconf > /dev/null && gpgconf --kill all; \
    rm -rf "$GNUPGHOME"; \
    fi; apk del .fetch-deps

ENV PHPDEV argon2-dev \
    coreutils \
    acl-dev \
    libxml2-dev \
    bzip2-dev \
    curl-dev \
    libedit-dev \
    openssl-dev \
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
    libzip-dev

RUN set -xe \
    && apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} ${PHPDEV} \
    && cd /usr/src \
    && tar -xvzf php.tar.gz && rm php.tar.gz \
    && cd /usr/src/php-${PHP_VERSION} \
    && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && ./configure \
    --build="$gnuArch" \
    --enable-option-checking=fatal \
    --disable-debug \
    --disable-rpath \
    --enable-fpm \
    --disable-cgi \
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
    --with-sodium=shared \
    --with-libedit \
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
    $(test "$gnuArch" = 's390x-linux-gnu' && echo '--without-pcre-jit') \
    && make -j "$(nproc)" &&  make install && make clean \
    && cd / && rm -rf /usr/src/php-${PHP_VERSION} \
    && apk del .build-deps \
    && rm -rf /tmp/pear ~/.pearrc

ENV EXT_MONGO_VERSION 1.5.3
ENV EXT_REDIS 4.2.0

RUN set -xe \
    && apk add --no-cache --virtual .build-deps curl ${PHPIZE_DEPS} \
    && cd /usr/src \
    && curl -fSL "http://pecl.php.net/get/mongodb-${EXT_MONGO_VERSION}.tgz" -o mongodb.tgz \
    && tar -xvzf mongodb.tgz && rm mongodb.tgz \
    && cd mongodb-${EXT_MONGO_VERSION} \
    && phpize \
    && ./configure --with-php-config=php-config \
    && make -j "$(nproc)" &&  make install && make clean \
    && cd / && rm -rf /usr/src/mongodb-${EXT_MONGO_VERSION} \
    && cd /usr/src \
    && curl -fSL "http://pecl.php.net/get/redis-${EXT_REDIS}.tgz" -o redis.tgz \
    && tar -xvzf redis.tgz && rm redis.tgz \
    && cd redis-${EXT_REDIS} \
    && phpize \
    && ./configure --with-php-config=php-config \
    && make -j "$(nproc)" &&  make install && make clean \
    && cd / && rm -rf /usr/src/redis-${EXT_REDIS} \
    && apk del .build-deps \
    && rm -rf /tmp/pear ~/.pearrc

COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

VOLUME /usr/local/etc/php-fpm.d

EXPOSE 9000

STOPSIGNAL SIGTERM

CMD ["php-fpm"]