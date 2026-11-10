FROM node:26-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    ripgrep \
  && rm -rf /var/lib/apt/lists/*

ARG OPENCODE_VERSION=2.2.7
RUN npm i -g "@opencode/cli@${OPENCODE_VERSION}" \
  && opencode --version
RUN mkdir -p \
      /home/node/.config/opencode \
      /home/node/.local/share/opencode \
      /home/node/.local/state/opencode \
      /home/node/.cache/opencode \
  && chown -R node:node /home/node

ENV XDG_CONFIG_HOME=/home/node/.config \
    XDG_DATA_HOME=/home/node/.local/share \
    XDG_STATE_HOME=/home/node/.local/state \
    XDG_CACHE_HOME=/home/node/.cache

USER node
WORKDIR /workspace
ENTRYPOINT ["opencode"]
CMD ["--standalone"]

FROM base AS full
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    fzf \
  && rm -rf /var/lib/apt/lists/*
USER node
