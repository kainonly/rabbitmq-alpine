FROM alpine:latest

ENV RABBITMQ_VERSION 3.7.8
ENV RABBITMQ_HOME /opt/rabbitmq
ENV PATH $RABBITMQ_HOME/sbin:$PATH
ENV HOME /var/lib/rabbitmq
ENV GPG_KEY 0A9AF2115F4687BD29803A206B73A36E6026DFCA

RUN addgroup -S rabbitmq \
    && adduser -D -S -h /var/lib/rabbitmq -G rabbitmq rabbitmq \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && mkdir -p /var/lib/rabbitmq /etc/rabbitmq /var/log/rabbitmq /tmp/rabbitmq-ssl \
    && chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /etc/rabbitmq /var/log/rabbitmq /tmp/rabbitmq-ssl \
    && chmod -R 777 /var/lib/rabbitmq /etc/rabbitmq /var/log/rabbitmq /tmp/rabbitmq-ssl \
    && apk add --no-cache 'su-exec>=0.2' bash procps erlang-asn1 erlang-hipe erlang-crypto erlang-eldap erlang-inets \
    erlang-mnesia erlang erlang-os-mon erlang-public-key erlang-sasl erlang-ssl erlang-syntax-tools erlang-xmerl 

RUN apk add --no-cache --virtual .build-deps ca-certificates gnupg libressl curl xz \
    && curl -fSL https://github.com/rabbitmq/rabbitmq-server/releases/download/v$RABBITMQ_VERSION/rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.xz.asc -o rabbitmq-server.tar.xz.asc \
    && curl -fSL https://github.com/rabbitmq/rabbitmq-server/releases/download/v$RABBITMQ_VERSION/rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.xz -o rabbitmq-server.tar.xz \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
    && gpg --batch --verify rabbitmq-server.tar.xz.asc rabbitmq-server.tar.xz \
    && command -v gpgconf && gpgconf --kill all || : \
    && rm -rf "$GNUPGHOME" \
    && mkdir -p "$RABBITMQ_HOME" \
    && tar --extract --verbose --file rabbitmq-server.tar.xz --directory "$RABBITMQ_HOME" --strip-components 1 \
    && rm -f rabbitmq-server.tar.xz* \
    && grep -qE '^SYS_PREFIX=\$\{RABBITMQ_HOME\}$' "$RABBITMQ_HOME/sbin/rabbitmq-defaults" \
    && sed -ri 's!^(SYS_PREFIX=).*$!\1!g' "$RABBITMQ_HOME/sbin/rabbitmq-defaults" \
    && grep -qE '^SYS_PREFIX=$' "$RABBITMQ_HOME/sbin/rabbitmq-defaults" \
    && apk del .build-deps 

RUN ln -sf /var/lib/rabbitmq/.erlang.cookie /root/ \ 
    && ln -sf "$RABBITMQ_HOME/plugins" /plugins

RUN rabbitmq-plugins enable rabbitmq_management rabbitmq_stomp rabbitmq_web_stomp rabbitmq_mqtt rabbitmq_web_mqtt

COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY advanced.config /etc/rabbitmq/advanced.config

VOLUME /var/lib/rabbitmq

EXPOSE 5672 1883 61613 15672 15674 15675 25672

STOPSIGNAL SIGTERM

CMD ["rabbitmq-server"]