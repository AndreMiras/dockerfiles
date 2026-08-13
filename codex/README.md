# Codex CLI

## Build
Build default full image (`latest`):
```sh
docker build \
  --tag codex:latest \
  https://github.com/AndreMiras/dockerfiles.git#main:codex
```

Build minimal base image:
```sh
docker build \
  --target base \
  --tag codex:base \
  https://github.com/AndreMiras/dockerfiles.git#main:codex
```

Build full image with a pinned Codex CLI version:
```sh
VERSION=0.145.0
docker build \
  --build-arg CODEX_VERSION=$VERSION \
  --tag codex:$VERSION \
  https://github.com/AndreMiras/dockerfiles.git#main:codex
```

Build base image with a pinned Codex CLI version:
```sh
VERSION=0.145.0
docker build \
  --target base \
  --build-arg CODEX_VERSION=$VERSION \
  --tag codex:$VERSION-base \
  https://github.com/AndreMiras/dockerfiles.git#main:codex
```

## Run

Then run Codex CLI with:
```sh
docker run -it --rm \
  --volume "$(pwd):/workspace" \
  --volume ~/.codex:/home/node/.codex \
  --volume ~/.agents:/home/node/.agents:ro \
  --volume ~/.gitconfig:/home/node/.gitconfig:ro \
  --volume ~/.config/gh:/home/node/.config/gh:ro \
  --workdir /workspace \
  --env GH_TOKEN \
  --env OPENAI_API_KEY \
  --env XDG_CONFIG_HOME=/home/node/.config \
  --env XDG_CACHE_HOME=/home/node/.cache \
  --user node \
  codex:$VERSION # or codex:latest or codex:base
```

## Leverage Dev Container CLI

```sh
npx @devcontainers/cli up \
  --workspace-folder . \
  --remove-existing-container \
  --build-no-cache
npx @devcontainers/cli exec --workspace-folder . codex
```

Then the `.devcontainer/devcontainer.json` could be:
```json
{
  "name": "Codex CLI with Host Tools",
  "image": "codex:latest",
  "remoteEnv": {
    "GH_TOKEN": "${localEnv:GH_TOKEN}",
    "OPENAI_API_KEY": "${localEnv:OPENAI_API_KEY}",
    "XDG_CONFIG_HOME": "/home/node/.config",
    "XDG_CACHE_HOME": "/home/node/.cache"
  },
  "mounts": [
    "source=${localEnv:HOME}/.codex,target=/home/node/.codex,type=bind",
    "source=${localEnv:HOME}/.agents,target=/home/node/.agents,type=bind,readonly",
    "source=${localEnv:HOME}/.gitconfig,target=/home/node/.gitconfig,type=bind,readonly",
    "source=${localEnv:HOME}/.config/gh,target=/home/node/.config/gh,type=bind,readonly"
  ],
  "workspaceFolder": "/workspace",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind",
  "remoteUser": "node"
}
```

## Image Variants

- `codex:latest`: full convenience image (default build output)
- `codex:base`: minimal image (`--target base`)
- `codex:<version>`: full image pinned with `CODEX_VERSION`
- `codex:<version>-base`: minimal image pinned with `CODEX_VERSION`

## Included Tools by Variant

- `codex:base`: `git`
- `codex:latest`: `git`, `rg` (`ripgrep`)
