FROM centos:7

MAINTAINER edison@amixsi.com.br

ADD install.sh /usr/local/bin/
RUN install.sh

ENV GOSU_VERSION 1.10
RUN curl -sS -Lo /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64 && \
  chmod +x /usr/local/bin/gosu

RUN groupadd -r user && useradd -g user user
RUN mkdir /app && chown user:user /app
VOLUME /app
WORKDIR /app

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["bash"]
