# Cardpeek Docker image

Automatically builds an environment for running [Cardpeek](https://github.com/L1L1/cardpeek).

## Build
Automatically clone and build:
```
docker build -t cardpeek:latest https://github.com/AndreMiras/dockerfiles.git#master:cardpeek
```
Or clone it yourself, then build it:
```
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/cardpeek/
docker build -t cardpeek:latest .
```

## Run
First run the `xhost` command to give local `root` user acess to the X server.
```
xhost SI:localuser:root
```
Then run the new container.
```
docker run -it --rm --privileged \
-v /dev/bus/usb:/dev/bus/usb \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY \
cardpeek
```

## Use
Run Cardpeek from the container.
```
cardpeek
```
