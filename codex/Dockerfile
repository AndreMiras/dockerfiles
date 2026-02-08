FROM node:24-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    ripgrep \
  && rm -rf /var/lib/apt/lists/*

ARG CODEX_VERSION=0.98.0
RUN npm i -g @openai/codex@${CODEX_VERSION}

WORKDIR /workspace
ENTRYPOINT ["codex"]
