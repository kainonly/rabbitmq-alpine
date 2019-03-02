## RabbitMQ-Alpine

Docker Pull Command

```shell
docker pull kainonly/rabbitmq-alpine
```

Set docker-compose

```yaml
version: '3.7'
services:
  rabbitmq:
    image: kainonly/rabbitmq-alpine
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

You can also use the nginx proxy rabbitmq tcp

- **amqp** `5672`
- **clustering** `25672`
- **http** `15672`
- **stomp** `61613`
- **web-stomp** `15674`
- **mqtt** `1883`
- **web-mqtt** `15675`
