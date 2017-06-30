FROM centos:7

MAINTAINER edison@amixsi.com.br

ADD install.sh /usr/local/bin/
RUN install.sh

WORKDIR /app