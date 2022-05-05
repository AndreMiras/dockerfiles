FROM ubuntu:18.04
MAINTAINER Andre Miras

RUN apt update && apt install -y \
    --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    ca-certificates \
    libcurl4-openssl-dev \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libglib2.0-dev \
    libgtk-3-dev \
    liblua5.2-dev \
    libpcsclite-dev \
    libssl-dev \
    pcscd \
    pkg-config \
    supervisor \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates \
    && wget 'https://github.com/L1L1/cardpeek/archive/cardpeek-0.8.4.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/cardpeek-0.8.4.tar.gz --directory /tmp/ \
    && cd /tmp/cardpeek-cardpeek-0.8.4/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/cardpeek-cardpeek-0.8.4/

# "/etc/supervisor/conf.d/*.conf" gets loaded by "/etc/supervisor/supervisord.conf"
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

ENV LANG C.UTF-8

WORKDIR /root

ENTRYPOINT ["/start.sh"]
