FROM ubuntu:16.04
MAINTAINER Andre Miras

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    wget \
    build-essential \
    gcc \
    dh-autoreconf \
    libnfc-dev \
    pkg-config \
    ca-certificates \
    && update-ca-certificates \
    && wget 'https://github.com/nfc-tools/mfoc/archive/mfoc-0.10.7.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/mfoc-0.10.7.tar.gz --directory /tmp/ \
    && cd /tmp/mfoc-mfoc-0.10.7/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install

ENV LANG C.UTF-8
ENV HOME /home/user

RUN useradd --create-home --home-dir $HOME user \
    && chown -R user:user $HOME

WORKDIR $HOME
USER user
