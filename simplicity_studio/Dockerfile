FROM ubuntu:16.04
MAINTAINER Andre Miras

# COPY SimplicityStudio-v4.tgz /data/

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    libegl1-mesa \
    wget \
    libgtk2.0-0 \
    libxtst6 \
    sudo \
    ca-certificates \
    && update-ca-certificates \
    # && wget 'https://www.silabs.com/Support%20Documents/Software/SimplicityStudio-v4.tgz' \
    && tar -xvzf /data/SimplicityStudio-v4.tgz -C /data/ \
    && mkdir -p /etc/udev/rules.d

ENV LANG C.UTF-8

WORKDIR /root
