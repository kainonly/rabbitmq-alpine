FROM rabbitmq:3.7.15-alpine

RUN rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_mqtt \
    rabbitmq_web_mqtt \
    rabbitmq_stomp \	
    rabbitmq_web_stomp

EXPOSE 5672 1883 15672 15674 15675 61613
