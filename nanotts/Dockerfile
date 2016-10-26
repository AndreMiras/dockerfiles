FROM ubuntu:16.04
MAINTAINER Andre Miras

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    software-properties-common \
    ca-certificates \
    alsa-utils \
    wget \
    unzip \
    build-essential \
    automake \
    libtool \
    libao-dev \
    && add-apt-repository multiverse \
    && apt-get update && apt-get install -y \
    libttspico-data \
    && update-ca-certificates \
    && wget 'https://github.com/gmn/nanotts/archive/master.zip' \
    -O /tmp/master.zip \
    && unzip /tmp/master.zip -d /tmp/ \
    && cd /tmp/nanotts-master/ \
    && make \
    && mv /tmp/nanotts-master/nanotts /usr/local/bin/ \
    && rm -r /tmp/nanotts-master/ \
    && rm /tmp/master.zip


COPY start.sh /start.sh

ENV LANG C.UTF-8

WORKDIR /root

ENTRYPOINT ["/start.sh"]
