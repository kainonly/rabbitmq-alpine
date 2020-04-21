FROM rabbitmq:3.8.3-alpine

RUN rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_shovel \
    rabbitmq_shovel_management \
    rabbitmq_stomp \
    rabbitmq_web_stomp

EXPOSE 5671 5672 15672 15674 61613
