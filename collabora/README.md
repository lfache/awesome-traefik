## Netxcloud sample configuration
### Nextcloud examples with traefik

Project structure:
```
.
├── docker-compose.yaml
└── README.md
```

[_docker-compose.yaml_](docker-compose.yaml)
```
version: '3.7'
services:
  app:

```

The compose file defines an application *Collabora*.

## Prerequisites

Launch *Traefik* first. Please refer at `README.md` [here](https://github.com/lfache/awesome-traefik/blob/master/README.md) for more information.

## Deploy with docker-compose
This repository uses environment variables to pass `COLLABORA_URL`, `COLLABORA_ADMIN_USER`, `COLLABORA_ADMIN_PASSWORD` to your stack.

```
$ COLLABORA_URL=nextcloud.mydomain.com COLLABORA_ADMIN_USER=admin COLLABORA_ADMIN_PASSWORD=mypassword docker-compose up 

```

## Expected result

Listing containers must show two containers running:
```
$ docker ps
```


Stop and remove the containers
```
$ docker-compose down
```

Stop and remove containers and volumes
```
$ docker-compose down -v
```
