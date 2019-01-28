# Build with:
# docker build -t mynfctools:latest .
# Run with:
# docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb mynfctools
FROM ubuntu:18.04
MAINTAINER Andre Miras

RUN apt update && apt install -y \
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
    pcsc-tools \
    pcscd \
    libpcsclite-dev \
    swig \
    supervisor \
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
    https://github.com/AdamLaurie/RFIDIOt/archive/27b212d.zip \
    pycrypto==2.6.1 \
    pyscard==1.9.4

# "/etc/supervisor/conf.d/*.conf" gets loaded by "/etc/supervisor/supervisord.conf"
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

ENV LANG C.UTF-8

WORKDIR /root

ENTRYPOINT ["/start.sh"]
