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
docker build \
  --build-arg CODEX_VERSION=0.98.0 \
  --tag codex:0.98.0 \
  https://github.com/AndreMiras/dockerfiles.git#main:codex
```

Build base image with a pinned Codex CLI version:
```sh
docker build \
  --target base \
  --build-arg CODEX_VERSION=0.98.0 \
  --tag codex:0.98.0-base \
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
  --workdir /workspace \
  --env OPENAI_API_KEY \
  --env XDG_CONFIG_HOME=/home/node/.config \
  --env XDG_CACHE_HOME=/home/node/.cache \
  --user node \
  codex:latest  # or codex:base
```

## Image Variants

- `codex:latest`: full convenience image (default build output)
- `codex:base`: minimal image (`--target base`)
- `codex:<version>`: full image pinned with `CODEX_VERSION`
- `codex:<version>-base`: minimal image pinned with `CODEX_VERSION`

## Included Tools by Variant

- `codex:base`: `git`
- `codex:latest`: `git`, `rg` (`ripgrep`)
