## RabbitMQ Alpine

Docker Image of RabbitMQ with MQTT & MQTT WS protocol

![MicroBadger Size](https://img.shields.io/microbadger/image-size/kainonly/rabbitmq-alpine.svg?style=flat-square)
![MicroBadger Layers](https://img.shields.io/microbadger/layers/kainonly/rabbitmq-alpine.svg?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/kainonly/rabbitmq-alpine.svg?style=flat-square)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/kainonly/rabbitmq-alpine.svg?style=flat-square)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/kainonly/rabbitmq-alpine.svg?style=flat-square)

```shell
docker pull kainonly/rabbitmq-alpine
```

Set docker-compose

```yml
version: '3.7'
services:
  rabbitmq:
    image: kainonly/rabbitmq-alpine
    restart: always
    hostname: 'localhost'
    ports:
      - 5672:5672
      - 1883:1883
      - 15672:15672
      - 15675:15675
```

You can also use the nginx proxy rabbitmq tcp

- **amqp** `5672`
- **http** `15672`
- **mqtt** `1883`
- **web-mqtt** `15675`
