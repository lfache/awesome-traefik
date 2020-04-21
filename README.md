# Awesome Traefik
Welcome to Awesome Traefik, a collection of contributions around Traefik and Docker/Docker-Compose.

These samples provide a starting point for how to integrate different services using a Compose file and to manage their deployment with Docker Compose and Traefik.

<!--lint disable awesome-toc-->
## Getting started
These instructions will get you through the bootstrap phase of creating and deploying samples of containerized applications with Docker Compose and Traefik.

### Prerequisites
- Make sure that you have Docker and Docker Compose installed
  - Windows or macOS:
    [Install Docker Desktop](https://www.docker.com/get-started)
  - Linux: [Install Docker](https://www.docker.com/get-started) and then
    [Docker Compose](https://github.com/docker/compose)
- Download some or all of the samples from this repository.
- Launch Traefik first. 

### Launch Traefik
- It is also necessary to launch an instance of Traefik beforehand. You can find the docker-compose file here :
  - Traefik HTTPS with let's encrypt, ssl redirection and by default some security headers :
    [Traefik service](https://github.com/lfache/awesome-traefik/blob/master/traefik/) Check the README.md of each sample to get more details 
  
### Running a sample

The root directory of each sample contains the `docker-compose.yaml` which
describes the configuration of service components. All samples can be run in
a local environment by going into the root directory of each one and executing:

```console
docker-compose up -d
```

Check the `README.md` of each sample to get more details on the structure and
what is the expected output.
To stop and remove the all containers of the sample application run:

```console
docker-compose down
```
<!--lint disable awesome-toc-->
## Contribute

We welcome examples that help people understand how to use Docker Compose for
common applications. 
