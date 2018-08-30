FROM amixsi/centos:7

LABEL maintainer=edison@amixsi.com.br

ADD install.sh /tmp/
RUN /tmp/install.sh

WORKDIR /app

ENTRYPOINT ["entrypoint.sh"]

CMD ["bash"]
