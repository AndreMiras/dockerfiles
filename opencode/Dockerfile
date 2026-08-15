FROM node:26-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG OPENCODE_VERSION=1.18.18
RUN npm i -g opencode-ai@${OPENCODE_VERSION}
RUN mkdir -p \
      /home/node/.config/opencode \
      /home/node/.local/share/opencode \
      /home/node/.local/state/opencode \
      /home/node/.cache \
  && chown -R node:node /home/node

WORKDIR /workspace
ENTRYPOINT ["opencode"]

FROM base AS full
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    fzf \
    ripgrep \
  && rm -rf /var/lib/apt/lists/*
