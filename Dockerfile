FROM centos:7

MAINTAINER edison@amixsi.com.br

ADD install.sh /tmp/
WORKDIR /tmp
RUN ./install.sh

WORKDIR /app