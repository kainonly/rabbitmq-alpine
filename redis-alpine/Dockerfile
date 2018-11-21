FROM alpine:3.8
ENV REDIS_VERSION 5.0.1
ENV SHA 82a67c0eec97f9ad379384c30ec391b269e17a3e4596393c808f02db7595abcb
RUN addgroup -S redis \
    && adduser -D -S -h /data -s /sbin/nologin -G redis redis \
    && apk add --no-cache 'su-exec>=0.2' tzdata \
    && apk add --no-cache --virtual .build-deps \
    coreutils \
    gcc \
    jemalloc-dev \
    linux-headers \
    curl \
    make \
    musl-dev \
    && curl -fSL http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz -o redis.tar.gz \
    && echo "$SHA *redis.tar.gz" | sha256sum -c - \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && rm redis.tar.gz \
    && grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h \
    && sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h \
    && grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h \
    && make -C /usr/src/redis -j "$(nproc)" \
    && make -C /usr/src/redis install \
    && rm -r /usr/src/redis \
    \
    && runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --virtual .redis-rundeps $runDeps \
    && apk del .build-deps

COPY redis.conf /etc/redis.conf

EXPOSE 6379

STOPSIGNAL SIGTERM

CMD ["redis-server","/etc/redis.conf"]