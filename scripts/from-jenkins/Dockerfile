FROM jenkins/jenkins:2.422-jdk17

USER root

RUN apt-get update && apt-get install -y \
  lsb-release \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io

USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow templating-engine:2.5.3"

EXPOSE 8080
