# Codex CLI

## Build
```sh
docker build \
  --tag codex:latest \
  https://github.com/AndreMiras/dockerfiles.git#main:codex
```

Or overriding the Codex CLI version:
```sh
docker build \
  --build-arg CODEX_VERSION=0.98.0 \
  --tag codex:0.98.0 \
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
  codex:latest
```

## Included Tools

- `git`
- `rg` (`ripgrep`)
