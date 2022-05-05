# Build with:
# docker build -t nfc-tools .
# Run with:
# docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb nfc-tools
FROM ubuntu:18.04
MAINTAINER Andre Miras

RUN apt update && apt install -y \
    --no-install-recommends \
    build-essential \
    ca-certificates \
    dh-autoreconf \
    gcc \
    libnfc-bin \
    libnfc-dev \
    libpcsclite-dev \
    pcsc-tools \
    pcscd \
    pkg-config \
    python \
    python-pip \
    python-setuptools \
    python-dev \
    supervisor \
    swig \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates \
    && wget 'https://github.com/nfc-tools/mfoc/archive/mfoc-0.10.7.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/mfoc-0.10.7.tar.gz --directory /tmp/ \
    && cd /tmp/mfoc-mfoc-0.10.7/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install \
    && cd \
    && rm -rf /tmp/mfoc-mfoc-0.10.7/ \
    && wget 'https://github.com/nfc-tools/mfcuk/archive/mfcuk-0.3.8.tar.gz' --directory-prefix /tmp/ \
    && tar -xvzf /tmp/mfcuk-0.3.8.tar.gz --directory /tmp/ \
    && cd /tmp/mfcuk-mfcuk-0.3.8/ \
    && autoreconf -vis \
    && ./configure \
    && make \
    && make install \
    && cd \
    && rm -rf /tmp/mfcuk-mfcuk-0.3.8/ \
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
