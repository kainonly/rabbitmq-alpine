FROM alpine:edge

ENV VERSION 1.14.2

RUN addgroup -g 82 -S nginx \
    && adduser -u 82 -D -S -h /var/cache/nginx -s -G nginx nginx \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache nginx

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME /etc/nginx/vhost /var/log/nginx

EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]