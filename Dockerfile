FROM rabbitmq:3.8.7-management-alpine

RUN rabbitmq-plugins enable --offline \
    rabbitmq_shovel \
    rabbitmq_shovel_management \
    rabbitmq_stomp \
    rabbitmq_web_stomp
