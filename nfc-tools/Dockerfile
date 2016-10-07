FROM ubuntu:16.04
MAINTAINER Andre Miras

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    wget \
    build-essential \
    gcc \
    dh-autoreconf \
    libnfc-dev \
    libnfc-bin \
    pkg-config \
    ca-certificates \
    python \
    python-pip \
    python-setuptools \
    python-dev \
    && update-ca-certificates \
    && wget 'https://github.com/nfc-tools/mfoc/archive/mfoc-0.10.7.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/mfoc-0.10.7.tar.gz --directory /tmp/ \
    && cd /tmp/mfoc-mfoc-0.10.7/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install \
    && wget 'https://github.com/nfc-tools/mfcuk/archive/mfcuk-0.3.8.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/mfcuk-0.3.8.tar.gz --directory /tmp/ \
    && cd /tmp/mfcuk-mfcuk-0.3.8/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install \
    && pip install \
    https://github.com/AdamLaurie/RFIDIOt/archive/master.zip \
    pycrypto==2.6.1

ENV LANG C.UTF-8

WORKDIR /root
