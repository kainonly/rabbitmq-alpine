FROM alpine:latest

ENV VERSION 4.0.11

RUN addgroup -S redis \
    && adduser -D -S -h /data -G redis redis \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache redis

COPY override.conf /etc/override.conf
COPY redis.conf /etc/redis.conf

VOLUME /data

EXPOSE 6379

STOPSIGNAL SIGTERM

CMD ["redis-server","/etc/redis.conf"]