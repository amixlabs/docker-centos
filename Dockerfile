FROM centos:5

LABEL maintainer=edison@amixsi.com.br

ADD install.sh /tmp/
RUN /tmp/install.sh && mkdir /app

WORKDIR /app
VOLUME /app

CMD ["bash"]
