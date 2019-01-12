## RabbitMQ-Alpine

RabbitMQ minimalist custom image

- size `46.8` mb
- version `3.7.8`

Docker Pull Command

```shell
docker pull kainonly/rabbitmq-alpine
```

Set docker-compose

```yaml
version: '3'
services:
  rabbitmq:
    image: kainonly/rabbitmq-alpine:3.7.8
    restart: always
    hostname: 'localhost'
    ports:
      - 5672:5672
      - 1883:1883
      - 61613:61613
      - 15672:15672
      - 15674:15674
      - 15675:15675
      - 25672:25672
```