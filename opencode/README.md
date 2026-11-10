# OpenCode

## Build
Build default full image (`latest`):
```sh
docker build \
  --tag opencode:latest \
  https://github.com/AndreMiras/dockerfiles.git#main:opencode
```

Build minimal base image:
```sh
docker build \
  --target base \
  --tag opencode:base \
  https://github.com/AndreMiras/dockerfiles.git#main:opencode
```

Build full image with a pinned OpenCode version:
```sh
VERSION=1.19.5
docker build \
  --build-arg OPENCODE_VERSION=$VERSION \
  --tag opencode:$VERSION \
  https://github.com/AndreMiras/dockerfiles.git#main:opencode
```

Build base image with a pinned OpenCode version:
```sh
VERSION=1.19.5
docker build \
  --target base \
  --build-arg OPENCODE_VERSION=$VERSION \
  --tag opencode:$VERSION-base \
  https://github.com/AndreMiras/dockerfiles.git#main:opencode
```

## Configure

Prepare the config, data and state directories if it's your first run, so they
aren't created root-owned by Docker:
```sh
mkdir -p \
  ~/.config/opencode \
  ~/.local/share/opencode \
  ~/.local/state/opencode
```

OpenCode ships with 75+ built-in providers, so `~/.config/opencode/opencode.json`
is only needed for a custom OpenAI-compatible endpoint. Below with Abacus.AI
RouteLLM:
```sh
cat <<EOF > ~/.config/opencode/opencode.json
{
  "\$schema": "https://opencode.ai/config.json",
  "autoupdate": false,
  "provider": {
    "abacus": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Abacus RouteLLM",
      "options": {
        "baseURL": "https://routellm.abacus.ai/v1",
        "apiKey": "{env:ABACUS_API_KEY}"
      },
      "models": {
        "route-llm": { "name": "RouteLLM (auto)" }
      }
    }
  },
  "model": "abacus/route-llm"
}
EOF
```

Set `autoupdate` to `false` so OpenCode doesn't try to self-update the binary
baked into the image. Reading the key from the environment keeps credentials out
of both the image and `auth.json`.

List the model IDs available to your subscription to populate `models`:
```sh
curl https://routellm.abacus.ai/v1/models \
  --header "Authorization: Bearer $ABACUS_API_KEY" | jq '.data[].id'
```

## Run

Then run OpenCode with:
```sh
docker run -it --rm \
  --volume "$(pwd):/workspace" \
  --volume ~/.config/opencode:/home/node/.config/opencode \
  --volume ~/.local/share/opencode:/home/node/.local/share/opencode \
  --volume ~/.local/state/opencode:/home/node/.local/state/opencode \
  --volume "$HOME/.cache/opencode:/home/node/.cache/opencode" \
  --volume ~/.gitconfig:/home/node/.gitconfig:ro \
  --volume ~/.config/gh:/home/node/.config/gh:ro \
  --workdir /workspace \
  --env GH_TOKEN \
  --env ABACUS_API_KEY \
  --env XDG_CONFIG_HOME=/home/node/.config \
  --env XDG_DATA_HOME=/home/node/.local/share \
  --env XDG_STATE_HOME=/home/node/.local/state \
  --user node \
  opencode:$VERSION # or opencode:latest or opencode:base
```

## Leverage Dev Container CLI

```sh
npx @devcontainers/cli up \
  --workspace-folder . \
  --remove-existing-container \
  --build-no-cache
npx @devcontainers/cli exec --workspace-folder . opencode
```

Then the `.devcontainer/devcontainer.json` could be:
```json
{
  "name": "OpenCode with Host Tools",
  "image": "opencode:latest",
  "overrideCommand": true,
  "remoteEnv": {
    "GH_TOKEN": "${localEnv:GH_TOKEN}",
    "ABACUS_API_KEY": "${localEnv:ABACUS_API_KEY}",
    "XDG_CONFIG_HOME": "/home/node/.config",
    "XDG_DATA_HOME": "/home/node/.local/share",
    "XDG_STATE_HOME": "/home/node/.local/state"
  },
  "mounts": [
    "source=${localEnv:HOME}/.config/opencode,target=/home/node/.config/opencode,type=bind",
    "source=${localEnv:HOME}/.local/share/opencode,target=/home/node/.local/share/opencode,type=bind",
    "source=${localEnv:HOME}/.local/state/opencode,target=/home/node/.local/state/opencode,type=bind",
    "source=${localEnv:HOME}/.gitconfig,target=/home/node/.gitconfig,type=bind,readonly",
    "source=${localEnv:HOME}/.config/gh,target=/home/node/.config/gh,type=bind,readonly"
  ],
  "workspaceFolder": "/workspace",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind",
  "remoteUser": "node"
}
```

`overrideCommand` is required because the image sets `ENTRYPOINT ["opencode"]`,
which would otherwise exit immediately and leave nothing to `exec` into.

## Image Variants

- `opencode:latest`: full convenience image (default build output)
- `opencode:base`: minimal image (`--target base`)
- `opencode:<version>`: full image pinned with `OPENCODE_VERSION`
- `opencode:<version>-base`: minimal image pinned with `OPENCODE_VERSION`

## Included Tools by Variant

- `opencode:base`: `git`
- `opencode:latest`: `git`, `rg` (`ripgrep`), `fzf`, `curl`

Note that OpenCode shells out to `ripgrep` for its grep and glob tools, and to
`fzf` for some pickers. The `base` variant is functionally degraded rather than
merely less convenient.

## Agent Skills

OpenCode supports custom agent skills. Skills should be placed in `~/.config/opencode/skills/<name>/SKILL.md`. Each skill directory must contain a `SKILL.md` file with YAML frontmatter containing `name` and `description`.

To enable all custom skills, add the following to your `opencode.json`:

```json
{
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
```

## Persisted Paths

OpenCode follows the XDG base directory spec and spreads itself across three
locations rather than a single dotdir:

- `~/.config/opencode`: `opencode.json`, agents, commands, plugins
- `~/.local/share/opencode`: `auth.json`, `log/`, `project/` (sessions and messages)
- `~/.local/state/opencode`: TUI state and installation metadata

## Troubleshooting

### `EACCES: permission denied, mkdir '/home/node/.local/state'`

`/home/node/.local` does not exist in the `node` base image. When Docker sets up
the `~/.local/share/opencode` bind mount it creates the missing parent
directories as `root`, leaving the `node` user unable to create siblings inside
them.

The `mkdir`/`chown` step in the Dockerfile pre-creates those parents with the
right ownership, so Docker never has to invent them. Rebuild the image if you
are hitting this. Mounting `~/.local/state/opencode` explicitly, as the run
command above does, also works because the mount point itself is owned by the
host user.
