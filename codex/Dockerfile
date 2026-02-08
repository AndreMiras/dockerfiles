FROM node:24-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG CODEX_VERSION=0.98.0
RUN npm i -g @openai/codex@${CODEX_VERSION}

WORKDIR /workspace
ENTRYPOINT ["codex"]

FROM base AS full
RUN apt-get update && apt-get install -y --no-install-recommends \
    ripgrep \
  && rm -rf /var/lib/apt/lists/*
