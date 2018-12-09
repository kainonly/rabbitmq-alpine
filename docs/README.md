# All Image

> Docker custom container for more comprehensive scenarios

## nginx-alpine

- version `1.14.1`

Defined docker-compose.yaml

```yaml
version: '3'
services:
  nginx:
    build: ./
    restart: always
    volumes:
      - ./nginx/vhost:/etc/nginx/vhost
      - ./nginx/log:/var/log/nginx
      - ./website:/website
    ports:
      - 80:80
      - 443:443
```

## php-alpine

- version `7.3.0`

Defined docker-compose.yaml

```yaml
version: '3'
services:
  php:
    build: ./
    restart: always
    volumes:
      - ./website:/website
    ports:
      - 9000:9000
```

## rabbitmq-alpine

- version `3.7.8`

Defined docker-compose.yaml

```yaml
version: '3'
services:
  rabbitmq:
    build: ./
    restart: always
    volumes:
      - ./rabbitmq/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf
      - ./rabbitmq/lib:/var/lib/rabbitmq
    ports:
      - 5672:5672
      - 1883:1883
      - 61613:61613
      - 25672:25672
      - 15672:15672
      - 15674:15674
      - 15675:15675
```
  
## redis-alpine

- version `4.0.11`
- size `2.683M`

Defined docker-compose.yaml

```yaml
version: '3'
services:
  redis:
    build: ./
    restart: always
    privileged: true
    sysctls:
      net.core.somaxconn: 65535
    volumes:
      - ./redis/data:/data
      - ./redis/override.conf:/etc/override.conf
    ports:
      - 6379:6379
```