FROM node:24-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG CODEX_VERSION=0.144.6
RUN npm i -g @openai/codex@${CODEX_VERSION}

WORKDIR /workspace
ENTRYPOINT ["codex"]

FROM base AS full
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ripgrep \
  && rm -rf /var/lib/apt/lists/*
