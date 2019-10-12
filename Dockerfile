FROM rabbitmq:3.8.0-alpine

RUN rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_web_stomp

EXPOSE 5672 15672 15674
