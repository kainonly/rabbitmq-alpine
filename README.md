## RabbitMQ Alpine

Docker Image of RabbitMQ with AMQP & STOMP Websocket protocol

![MicroBadger Size](https://img.shields.io/microbadger/image-size/kainonly/rabbitmq-alpine.svg?style=flat-square)
![MicroBadger Layers](https://img.shields.io/microbadger/layers/kainonly/rabbitmq-alpine.svg?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/kainonly/rabbitmq-alpine.svg?style=flat-square)
[![Github Actions](https://img.shields.io/github/workflow/status/docker-maker/rabbitmq-alpine/release?style=flat-square)](https://github.com/docker-marker/rabbitmq-alpine/actions)

```shell
docker pull kainonly/rabbitmq-alpine
```

Included plugin

- **rabbitmq_management**
- **rabbitmq_shovel**
- **rabbitmq_shovel_management**
- **rabbitmq_stomp**
- **rabbitmq_web_stomp**

Set docker-compose

```yml
version: '3.8'
services:
  rabbitmq:
    image: kainonly/rabbitmq-alpine
    restart: always
    hostname: 'localhost'
    ports:
      - 5672:5672
      - 15672:15672
      - 15674:15674
```

You can also use the nginx proxy rabbitmq tcp

- **amqp** `5672`
- **stomp-websocket** `15674`
- **api** `15672`