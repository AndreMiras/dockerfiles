FROM ubuntu:16.04
MAINTAINER Andre Miras

# COPY SimplicityStudio-v4.tgz /tmp/

RUN apt update && apt install -y \
    --no-install-recommends \
    libegl1-mesa \
    wget \
    libgtk2.0-0 \
    libxtst6 \
    sudo \
    ca-certificates \
    && update-ca-certificates \
    && wget 'https://www.silabs.com/Support%20Documents/Software/SimplicityStudio-v4.tgz' -P /tmp/ \
    && tar -xvzf /tmp/SimplicityStudio-v4.tgz -C /opt/ \
    && mkdir -p /etc/udev/rules.d \
    && dpkg --add-architecture i386 \
    && apt update \
    && /opt/SimplicityStudio_v4/setup.sh

ENV LANG C.UTF-8

WORKDIR /root
