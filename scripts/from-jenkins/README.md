# Run Jenkins in Docker with docker-in-docker option

## Create a bridge network

```bash
docker network create jenkins
```

## Download and run docker-in-docker (dind)

Pull dind image

```bash
docker image pull docker:dind
```

Execute `run-docker-in-docker.sh` script

```bash
bash run-docker-in-docker.sh
```

## Build and run new Jenkins image with Docker CLI and Blue Ocean plugin

Build a new docker image from the Dockerfile in this folder: `scripts/from-jenkins`

```bash
docker build -t myjenkins-blueocean:2.422-1 .
```

Run the created image as a container executing the script `run-jenkins-blueocean`

```bash
bash run-jenkins-blueocean.sh
```
