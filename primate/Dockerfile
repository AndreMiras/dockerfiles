# Build:
# docker build -t andremiras/primate .
# Run:
# host should run: `xhost +` beforehand
# docker run -it --rm \
#   --env DISPLAY=$DISPLAY \
#   --volume /tmp/.X11-unix:/tmp/.X11-unix \
#   andremiras/primate
# Start from a base image that includes X11 libraries
FROM ubuntu:22.04

ENV USER="user"
ENV HOME_DIR="/home/${USER}"
ENV VERSION="1.1.0"
ENV WORK_DIR="${HOME_DIR}/Primate-v${VERSION}-x64" \
    PATH="${HOME_DIR}/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary libraries and tools
RUN apt-get update && apt-get install -y \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libfreetype6 \
    libgbm1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    wget \
    x11-apps \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${HOME_DIR}

RUN useradd --create-home --shell /bin/bash ${USER} \
    && chown --recursive ${USER}:${USER} ${HOME_DIR} \
    && wget --quiet https://github.com/getprimate/primate/releases/download/v${VERSION}/Primate-v${VERSION}-x64.tar.gz \
    && tar xf Primate-v${VERSION}-x64.tar.gz \
    && rm Primate-v${VERSION}-x64.tar.gz \
    && chmod 4755 Primate-v${VERSION}-x64/chrome-sandbox \
    && mkdir ${HOME_DIR}/.bin \
    && ln -sfn ${HOME_DIR}/Primate-v${VERSION}-x64/primate-ce ${HOME_DIR}/.bin

USER ${USER}

ENV DEBIAN_FRONTEND=

CMD ["sh", "-c", "${HOME_DIR}/.bin/primate-ce --no-sandbox"]
