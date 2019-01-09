FROM alpine:edge

ENV VERSION 3.7.8
ENV HOME /var/lib/rabbitmq

RUN addgroup -S rabbitmq \
    && adduser -D -S -h /var/lib/rabbitmq -G rabbitmq rabbitmq \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo '@testing http://nl.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories

RUN apk add --no-cache rabbitmq-server@testing

# RUN ln -sf /var/lib/rabbitmq/.erlang.cookie /root/ \ 
#     && ln -sf "$RABBITMQ_HOME/plugins" /plugins

# RUN rabbitmq-plugins enable rabbitmq_management rabbitmq_stomp rabbitmq_web_stomp rabbitmq_mqtt rabbitmq_web_mqtt

# COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
# COPY advanced.config /etc/rabbitmq/advanced.config

# VOLUME /var/lib/rabbitmq

# EXPOSE 5672 1883 61613 15672 15674 15675 25672

# STOPSIGNAL SIGTERM

# CMD ["rabbitmq-server"]