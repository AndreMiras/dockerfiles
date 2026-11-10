# OpenCode v2

OpenCode v2 installed from `@opencode/cli`, pinned to `2.2.7` by default.
The image runs as `node` and starts `opencode --standalone`, using a private
server for the container's terminal session.

## Build

Run these commands from the repository root. Build the default full image:

```sh
docker build --tag opencode2:latest ./opencode2
```

Build the minimal base image:

```sh
docker build --target base --tag opencode2:base https://github.com/AndreMiras/dockerfiles.git#main:opencode2
```

Build either variant with an explicit v2 version:

```sh
VERSION=2.2.7
docker build \
  --build-arg OPENCODE_VERSION="$VERSION" \
  --tag "opencode2:$VERSION" \
  https://github.com/AndreMiras/dockerfiles.git#main:opencode2
docker build \
  --target base \
  --build-arg OPENCODE_VERSION="$VERSION" \
  --tag "opencode2:$VERSION-base" \
  https://github.com/AndreMiras/dockerfiles.git#main:opencode2
```

### Image variants

| Tag | Tools |
| --- | --- |
| `opencode2:latest`, `opencode2:<version>` | `git`, `rg` (`ripgrep`), `curl`, `fzf` |
| `opencode2:base`, `opencode2:<version>-base` | `git`, `rg` (`ripgrep`) |

Both variants include `ripgrep`, as does the upstream v2 container.

## Configure

The examples use host directories named `opencode2`, mounted at OpenCode's
standard in-container paths. Prepare all four before the first run:

```sh
mkdir -p \
  "$HOME/.config/opencode2" \
  "$HOME/.local/share/opencode2" \
  "$HOME/.local/state/opencode2" \
  "$HOME/.cache/opencode2"
```

Create a global configuration to disable update checks for the version baked
into the image:

```sh
cat > "$HOME/.config/opencode2/opencode.json" <<'EOF'
{
    "$schema": "https://opencode.ai/config.json",
    "update": "disable"
}
EOF
```

For built-in providers, start the container and use `/connect`, then `/models`.
Credentials are persisted in the mounted data directory.

### Abacus.AI RouteLLM

For the same OpenAI-compatible endpoint as the v1 image, use this configuration
instead. It uses native v2 configuration syntax and the same AI SDK adapter as
the v1 example:

```sh
cat > "$HOME/.config/opencode2/opencode.json" <<'EOF'
{
    "$schema": "https://opencode.ai/config.json",
    "update": "disable",
    "providers": {
        "abacus": {
            "package": "aisdk:@ai-sdk/openai-compatible",
            "name": "Abacus RouteLLM",
            "settings": {
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

Export `ABACUS_API_KEY` on the host before running the container. Set the model
ID to one available to your subscription.

## Run

Run from the project you want OpenCode to work on:

```sh
docker run -it --rm \
  --volume "$(pwd):/workspace" \
  --volume "$HOME/.config/opencode2:/home/node/.config/opencode" \
  --volume "$HOME/.local/share/opencode2:/home/node/.local/share/opencode" \
  --volume "$HOME/.local/state/opencode2:/home/node/.local/state/opencode" \
  --volume "$HOME/.cache/opencode2:/home/node/.cache/opencode" \
  --env GH_TOKEN \
  --env ABACUS_API_KEY \
  opencode2:latest
```

Use `opencode2:base` or a versioned tag to select another build. To share Git
identity and GitHub CLI configuration, add these mounts when those host paths
exist:

```sh
--volume "$HOME/.gitconfig:/home/node/.gitconfig:ro" \
--volume "$HOME/.config/gh:/home/node/.config/gh:ro"
```

Both images default to `opencode --standalone`. Arguments after the image name
replace the default `--standalone` argument. For a noninteractive prompt, keep
the same mounts and environment variables and replace the image line with:

```sh
opencode2:latest run --standalone "Explain this repository"
```

This starts the provider-serving process with the forwarded environment and
keeps its lifecycle local to the command.

## Persisted paths

| Host path | Container path | Contents |
| --- | --- | --- |
| `~/.config/opencode2` | `/home/node/.config/opencode` | `opencode.json`, `cli.json`, agents, commands, skills, plugins |
| `~/.local/share/opencode2` | `/home/node/.local/share/opencode` | `opencode.db`, credentials, sessions, logs |
| `~/.local/state/opencode2` | `/home/node/.local/state/opencode` | Runtime/service state |
| `~/.cache/opencode2` | `/home/node/.cache/opencode` | Cached packages and binaries |

The image sets the XDG config, data, state, and cache roots and precreates these
directories with `node` ownership. Bind-mounted directories must also be
writable by the container's `node` user (UID/GID 1000).

## Agent skills

Place host skills at `~/.config/opencode2/skills/<skill-id>/SKILL.md`. Keep each
skill's scripts and references alongside its `SKILL.md` file. To allow all
skills, merge this native v2 permission rule into `opencode.json`:

```json
{
    "permissions": [
        { "action": "skill", "resource": "*", "effect": "allow" }
    ]
}
```

Existing skill files remain supported. Instructions containing literal v1 tool
calls may need updating; for example, the v2 `skill` tool takes `id`, not `name`.

## Leverage Dev Container CLI

After building `opencode2:latest` and preparing the host directories, use this
as the target project's `.devcontainer/devcontainer.json`:

```json
{
    "name": "OpenCode v2",
    "image": "opencode2:latest",
    "overrideCommand": true,
    "remoteEnv": {
        "GH_TOKEN": "${localEnv:GH_TOKEN}",
        "ABACUS_API_KEY": "${localEnv:ABACUS_API_KEY}"
    },
    "mounts": [
        "source=${localEnv:HOME}/.config/opencode2,target=/home/node/.config/opencode,type=bind",
        "source=${localEnv:HOME}/.local/share/opencode2,target=/home/node/.local/share/opencode,type=bind",
        "source=${localEnv:HOME}/.local/state/opencode2,target=/home/node/.local/state/opencode,type=bind",
        "source=${localEnv:HOME}/.cache/opencode2,target=/home/node/.cache/opencode,type=bind"
    ],
    "workspaceFolder": "/workspace",
    "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind",
    "remoteUser": "node"
}
```

```sh
npx @devcontainers/cli up --workspace-folder .
npx @devcontainers/cli exec --workspace-folder . opencode --standalone
```

`overrideCommand` keeps the development container alive for `exec`; the exec
command explicitly selects the private server mode.

## Trying existing v1 configuration and sessions

The [v1 image](../opencode/README.md) uses the separate host `opencode`
directories. To try existing sessions in v2, copy the v1 configuration and data
into fresh `opencode2` directories before launching v2. Stop processes writing
the source data first so the database and any WAL sidecars form a consistent
copy. Let v2 create its own cache and runtime state.

Supported v1 configuration, agents, commands, and skills can be read directly;
converting everything to native v2 syntax is optional. Review configured plugins
before the first run: v1 plugin implementations require a v2 port. V1 API clients
also need migration, and v2 does not run LSP servers.

V2 migrates persisted sessions and terminal settings. Use the original v1 image
with its original config/data for rollback; a version change alone does not
reverse the data migration. The workspace mount is still the same working
project, so project-local configuration and files are shared between runs.

See the [official migration guide](https://opencode.ai/docs/migrate-v1/) and
[plugin migration guide](https://opencode.ai/docs/build/plugins/migrate-v1/).

## Smoke checks

After building both variants:

```sh
docker run --rm opencode2:latest --version
docker run --rm opencode2:base --version
docker run --rm opencode2:latest --help
docker run --rm --entrypoint sh opencode2:base \
  -c 'id && opencode --version && rg --version && test -w "$XDG_STATE_HOME/opencode"'
```

Then use the mounted run command to verify your provider, a tool call, skill
loading, and any copied session history.
