FROM ubuntu:16.04
MAINTAINER Andre Miras

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    software-properties-common \
    ca-certificates \
    alsa-utils \
    && update-ca-certificates \
    && add-apt-repository multiverse \
    && apt-get update && apt-get install -y \
    libttspico-utils

ENV LANG C.UTF-8

WORKDIR /root
