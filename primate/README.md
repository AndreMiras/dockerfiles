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
docker build --tag andremiras/primate https://github.com/AndreMiras/dockerfiles.git#develop:primate
```

Or clone it yourself, then build it:

```sh
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/primate/
docker build --tag andremiras/primate .
```

## Tunnel to remote Kong instance

This is useful if your Kong admin (8001) is firewalled.

```sh
ssh -L 0.0.0.0:8001:localhost:8001 user@ip
```

Then on the Primate dashboard use the Docker host IP (`172.17.0.1:8001`) to connect.
