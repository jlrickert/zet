# Docker compose host name resolution

Docker compose is able to spin up multiple services where each service may
replicate a bunch of docker images. In many scenarios there needs to be
communication between services and instances.

Here is a stripped down Dockerfile that I have used in the past while developing
[battle tanks](../357).

```Dockerfile
version: '3'

services:
  game-server:
    build:
      context: .
      target: dev
    volumes:
      - .:/app
      - node_modules:/app/node_modules
    deploy:
      replicas: 3
  lobby:
    build:
      context: .
      target: dev
    volumes:
      - .:/app
      - node_modules:/app/node_modules
    deploy:
      replicas: 1

volumes:
  node_modules:
```

One things to not here is that you will have no access to the services on your
host (your PC) as there are no ports being published. This example spins up 1
instance of a lobby service and 3 game servers. Behind the scenes docker will
create a private network allowing communication. Each instance will have its own
assigned ip address. Each service will also have its own domain name (not sure
if what you would call it). For example, lobby will be lobby and game-server
will be game-server. Services may be accessed through these domain names. Here
is an example using curl:

```bash
docker-compose exec --user=root game-server sh
apk add curl
curl http://game-server:5173
curl http://lobby:5173
```

Each call to one of the services will be load balanced between on instance
within the storage.


