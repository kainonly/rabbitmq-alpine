FROM alpine:edge

ENV PHP_VERSION 7.2.13
ENV GPG_KEYS 1729F83938DA44E27BA0F4D3DBDB397470D12172 B1B44D8F021E4E2D6021E995DC9FF8D3EE5AF27F
ENV PHP_URL="https://secure.php.net/distributions/php-7.2.13.tar.gz" PHP_ASC_URL="https://secure.php.net/distributions/php-7.2.13.tar.gz.asc"
ENV PHP_SHA256="e563cee406b1ec96649c22ed2b35796cfe4e9aa9afa6eab6be4cf2fe5d724744" PHP_MD5=""
ENV PHPIZE_DEPS autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c

RUN set -x \
    && addgroup -g 82 -S nginx \
    && adduser -u 82 -D -S -G nginx nginx \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN set -xe \
    && apk add --no-cache --virtual .fetch-deps gnupg curl \
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
ENV EXT_MSGPACK 2.0.2

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
    && cd /usr/src \
    && curl -fSL "http://pecl.php.net/get/msgpack-${EXT_MSGPACK}.tgz" -o msgpack.tgz \
    && tar -xvzf msgpack.tgz && rm msgpack.tgz \
    && cd msgpack-${EXT_MSGPACK} \
    && phpize \
    && ./configure --with-php-config=php-config \
    && make -j "$(nproc)" &&  make install && make clean \
    && cd / && rm -rf /usr/src/msgpack-${EXT_MSGPACK} \
    && apk del .build-deps \
    && rm -rf /tmp/pear ~/.pearrc

COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

VOLUME /usr/local/etc/php-fpm.d

EXPOSE 9000

STOPSIGNAL SIGTERM

CMD ["php-fpm"]