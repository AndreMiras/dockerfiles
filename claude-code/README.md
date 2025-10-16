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
