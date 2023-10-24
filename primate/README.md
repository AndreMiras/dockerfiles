# Primate Docker image

Automatically builds an environment for running [Primate](https://github.com/getprimate/primate).

## Run

First run the `xhost` command to give local `root` user acess to the X server.

```sh
xhost SI:localuser:root
```

Then run the new container.

```sh
docker run -it --rm \
  --env DISPLAY=$DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  andremiras/primate
```

## Build

Automatically clone and build:

```sh
docker build -t primate https://github.com/AndreMiras/dockerfiles.git#develop:primate
```

Or clone it yourself, then build it:

```sh
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/primate/
docker build -t andremiras/primate .
```
