#!/bin/sh

docker run \
--rm \
-d \
--name jenkins-playground \
-v //var/run/docker.sock:/var/run/docker.sock \
-v jenkins_home_volume:/var/jenkins_home \
--privileged \
--user root \
-p 8080:8080 \
-p 50000:50000 \
jenkins:lts-docker
