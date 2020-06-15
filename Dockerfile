FROM rabbitmq:3.8.4-alpine

RUN rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_shovel \
    rabbitmq_shovel_management \
    rabbitmq_stomp \
    rabbitmq_web_stomp
