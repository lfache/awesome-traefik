## Jitsi sample configuration
### Jitsi meet with traefik

Project structure:
```
.
├── env.examples
├── docker-compose.yaml
├── gen-passwords.sh 
├── output.png 
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

* Create a ``.env`` file by copying and adjusting ``env.example``
  * `cp env.example .env`
  * Set strong passwords in the security section options: `./gen-passwords.sh`
* Create required `CONFIG` directories
  * `mkdir -p ./jitsi-meet-cfg/{web/letsencrypt,transcripts,prosody,jicofo,jvb,jigasi,jibri}`

## Security note

This setup used to have default passwords for internal accounts used across components. In order to make the default setup
secure by default these have been removed and the respective containers won't start without having a password set.

Strong passwords may be generated as follows: `./gen-passwords.sh`
This will modify your `.env` file (a backup is saved in `.env.bak`) and set strong passwords for each of the
required options. Passwords are generated using `openssl rand -hex 16` .

DO NOT reuse any of the passwords.

## Configuration

The configuration is performed via environment variables contained in a ``.env`` file. You
can copy the provided ``env.example`` file as a reference.

**IMPORTANT**: At the moment, the configuration is not regenerated on every container boot, so
if you make any changes to your ``.env`` file, make sure you remove the configuration directory
before starting your containers again.

Variable | Description | Example
--- | --- | ---
`CONFIG` | Directory where all configuration will be stored | /opt/jitsi-meet-cfg
`TZ` | System Time Zone | Europe/Amsterdam
`HTTP_PORT` | Exposed port for HTTP traffic | 8000
`HTTPS_PORT` | Exposed port for HTTPS traffic | 8443
`DOCKER_HOST_ADDRESS` | IP address of the Docker host, needed for LAN environments | 192.168.1.1
`PUBLIC_URL` | Public URL for the web service | https://meet.example.com

## Deploy with docker-compose

```
$ docker-compose up -d
Creating network "jitsi_meet.jitsi" with the default driver
Pulling web (jitsi/web:)...
latest: Pulling from jitsi/web
.
.
.
Creating jitsi_prosody_1 ... done
Creating jitsi_web_1     ... done
Creating jitsi_jicofo_1  ... done
Creating jitsi_jvb_1     ... done
```

## Expected result

Listing containers must show five containers running:
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                              NAMES
6c6dbf67ab95        jitsi/jvb           "/init"                  43 seconds ago      Up 40 seconds       0.0.0.0:4443->4443/tcp, 0.0.0.0:10000->10000/udp   jitsi_jvb_1
99b8959c5b42        jitsi/jicofo        "/init"                  43 seconds ago      Up 40 seconds                                                          jitsi_jicofo_1
48fb36b9e2eb        jitsi/prosody       "/init"                  46 seconds ago      Up 43 seconds       5222/tcp, 5269/tcp, 5280/tcp, 5347/tcp             jitsi_prosody_1
b433bac10479        jitsi/web           "/init"                  46 seconds ago      Up 42 seconds       80/tcp, 443/tcp                                    jitsi_web_1
17c8c153dcd4        traefik:2.2         "/entrypoint.sh trae…"   8 minutes ago       Up 8 minutes        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp           traefik_reverse_proxy_1
```

After the application starts, navigate to `https://jitsi.mydomain.com` in your web browser to access *Jitsi* :

![page](output.png)

Stop and remove the containers
```
$ docker-compose down
```

Stop and remove containers and volumes
```
$ docker-compose down -v
```
