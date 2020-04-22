## Jitsi sample configuration
### Jitsi meet with traefik

Project structure:
```
.
├── env.examples
├── docker-compose.yaml
└── README.md
```

[_docker-compose.yaml_](docker-compose.yaml)
```
version: '3.7'
services:
    # Frontend
    web:
      image: jitsi/web
	.
	.
	.
      labels:
        traefik.enable: true
        traefik.docker.network: traefik_web
        traefik.http.routers.jitsi.entrypoints: websecure
        traefik.http.routers.jitsi.rule: 'Host(`jitsi.mydomain.com`)'
        traefik.http.services.jitsi.loadbalancer.server.port: 80
	.
	.
	.
```

The compose file defines an application *Jitsi* with four services `web` , `prosody` , `jicofo`, `jvb`.
This stack use *Traefik* network and service as reverse-proxy.

For more information about *Jitsi Meet* : [https://github.com/jitsi/jitsi-meet/blob/master/doc/README.md]()

## Prerequisites

Launch *Traefik* first. Please refer at `README.md` [here](https://github.com/lfache/awesome-traefik/blob/master/README.md) for more information.

Modify ![page](env.examples) with your own password.

## Deploy with docker-compose

```
$ docker-compose up -d

```

## Expected result

Listing containers must show two containers running:
```
$ docker ps
```

After the application starts, navigate to `https://jitsi.mydomain.com` in your web browser to access wordpress installation:

![page](output.png)

Stop and remove the containers
```
$ docker-compose down
```

Stop and remove containers and volumes
```
$ docker-compose down -v
```
