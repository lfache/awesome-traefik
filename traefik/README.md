## Traefik sample configuration
### TRAEFIK proxy with SSL and security headers

Project structure:
```
.
├── custom
│   ├── middlewares.yaml
│   └── tls.yaml
├── docker-compose.yaml
└── traefik.yaml
└── README.md
```

[_docker-compose.yaml_](docker-compose.yaml)
```
version: "3.7"
services:
  reverse_proxy:
    image: traefik:2.2
    restart: unless-stopped
    ports:
      # The HTTP port
      - "80:80"
      # The HTTPS port
      - "443:443"
    volumes:
      # So that Traefik can listen to the Docker events
      - /var/run/docker.sock:/var/run/docker.sock
      # traefik static configuration
      - ./traefik.yaml:/etc/traefik/traefik.yaml:ro
      # custom folder with dynamic configuration
      - ./custom:/etc/traefik/custom:ro
      # ssl volumes to store acme.json
      - certs:/letsencrypt
    networks:
      - web

volumes:
  certs:

networks:
  web:
    name: traefik_web
```

The compose file defines an application *Traefik* with .
When deploying the application, docker-compose maps port 80 and 443 of the frontend service container to the same port of the host as specified in the file.
Make sure port 80 and 443 on the host is not already being in use.

## Deploy with docker-compose

```
$ docker-compose up -d
Creating network "traefik_web" with the default driver
Pulling reverse_proxy (traefik:2.2)...
2.2: Pulling from library/traefik
aad63a933944: Pull complete
f365f1b91ebb: Pull complete
dc367a6045f5: Pull complete
ff697159d003: Pull complete
Digest: sha256:615483752426932469aa2229ef3f0825b33b3ad7e1326dcd388205cb3a74352e
Status: Downloaded newer image for traefik:2.2
Creating traefik_reverse_proxy_1 ... done
```

## Expected result

Listing containers must show two containers running and the port mapping as below:
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                      NAMES
b2c95cb59ba3        traefik:2.2         "/entrypoint.sh trae…"   35 seconds ago      Up 33 seconds       0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   traefik_reverse_proxy_1
```

After the application starts, navigate to `http://localhost:80` in your web browser or run:
```
$ curl localhost:80
Moved Permanently
```
or 
```
$ curl localhost:443

```

Stop and remove the containers
```
$ docker-compose down
```

Stop and remove the containers and volumes
```
$ docker-compose down -v
```
