FROM centos:7

MAINTAINER edison@amixsi.com.br

ADD install.sh /usr/local/bin/
RUN install.sh

RUN curl -sS -Lo /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 && \
  chmod +x /usr/local/bin/gosu
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
