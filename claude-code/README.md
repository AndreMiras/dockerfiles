# Claude Code

## Build
```sh
docker build --tag claude-code-dev:latest https://github.com/anthropics/claude-code.git#main:.devcontainer
```

## Run

Prepare the `~/claude` directory and `~/.claude.json` file if it's your first run:
```sh
mkdir -p ~/.claude
cat <<EOF > ~/.claude.json
{
    "shiftEnterKeyBindingInstalled": true,
    "theme": "dark" ,
    "hasCompletedOnboarding": true
}
EOF
```
Then run claude with:
```sh
docker run -it --rm \
  --volume "$(pwd):/workspace" \
  --volume ~/.claude:/home/node/.claude \
  --volume ~/.claude.json:/home/node/.claude.json \
  --volume ~/.gitconfig:/home/node/.gitconfig:ro \
  --workdir /workspace \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  --user node \
  claude-code-dev:latest claude
```

## Leverage Dev Container CLI

```sh
npx @devcontainers/cli up --workspace-folder . --remove-existing-container
npx @devcontainers/cli exec --workspace-folder . claude
```

Then the `.devcontainer/devcontainer.json` could be:
```json
{
  "name": "Claude Code with Host Tools",
  "image": "claude-code-dev:latest",
  "remoteEnv": {
    "NPM_CONFIG_PREFIX": "",
    "NVM_DIR": "/home/node/.nvm"
  },
  "mounts": [
    "source=${localEnv:HOME}/.claude,target=/home/node/.claude,type=bind",
    "source=${localEnv:HOME}/.claude.json,target=/home/node/.claude.json,type=bind",
    "source=${localEnv:HOME}/.gitconfig,target=/home/node/.gitconfig,type=bind,readonly"
  ],
  "workspaceFolder": "/workspace",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind",
  "capAdd": [
    "NET_ADMIN",
    "NET_RAW"
  ],
  "remoteUser": "node",
  "postCreateCommand": "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash",
  "postStartCommand": "unset NPM_CONFIG_PREFIX && . ~/.nvm/nvm.sh && nvm install 22 && nvm alias default 22 && echo '. ~/.nvm/nvm.sh' >> ~/.bashrc"
}
```
