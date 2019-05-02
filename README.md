[![Build Status](https://travis-ci.org/amixsi/docker-centos.svg?branch=7.3)](https://travis-ci.org/amixsi/docker-centos)

# About this Repo

This is the Git repo of the official Docker image for [amixsi/centos](https://hub.docker.com/r/amixsi/centos/).
See the Hub page for the full readme on how to use the Docker image and for information regarding contributing and issues.

Common build usage:

```bash
docker build \
  --build-arg "http_proxy=$http_proxy" \
  --build-arg "https_proxy=$https_proxy" \
  --build-arg "no_proxy=$no_proxy" \
  -t amixsi/centos:latest \
  -t amixsi/centos:7.5 \
  .
```

Publish

```bash
docker login
docker push amixsi/centos
```

Handing permissions with docker volumes:

[Reference here](https://denibertovic.com/posts/handling-permissions-with-docker-volumes/)

Mapping your local user into container:

```bash
docker run -e LOCAL_USER_ID=$(id -u $USER) -it --rm amixsi/centos:7.5
```

or using `docker-compose.yml`:

```yml
version: '2'
services:
  shell:
    image: amixsi/centos:7.5
    command: 'bash'
    environment:
    - LOCAL_USER_ID
```

and create `.env` with:

```bash
LOCAL_USER_ID=501 # For example
```

and run `docker-compose run shell`
