FROM ubuntu:16.04
MAINTAINER Andre Miras

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    wget \
    build-essential \
    autoconf \
    pkg-config \
    ca-certificates \
    automake \
    pcscd \
    libpcsclite-dev \
    libglib2.0-dev \
    libgtk-3-dev \
    liblua5.2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    supervisor \
    && update-ca-certificates \
    && wget 'https://github.com/L1L1/cardpeek/archive/cardpeek-0.8.4.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/cardpeek-0.8.4.tar.gz --directory /tmp/ \
    && cd /tmp/cardpeek-cardpeek-0.8.4/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install

# "/etc/supervisor/conf.d/*.conf" gets loaded by "/etc/supervisor/supervisord.conf"
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

ENV LANG C.UTF-8

WORKDIR /root

ENTRYPOINT ["/start.sh"]
