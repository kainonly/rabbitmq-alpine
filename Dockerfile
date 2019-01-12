FROM rabbitmq:alpine

ENV VERSION 3.7.8

RUN rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_mqtt \
    rabbitmq_web_mqtt \
    rabbitmq_stomp \
    rabbitmq_web_stomp

EXPOSE 5672 1883 61613 15672 15674 15675 25672