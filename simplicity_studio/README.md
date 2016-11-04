# Simplicity Studio Docker image

Automatically builds an environment for running [SimplicityStudio](https://www.silabs.com).

## Build
Automatically clone and build:
```
docker build -t simplicity_studio:latest https://github.com/AndreMiras/dockerfiles.git#master:simplicity_studio
```
Or clone it yourself, then build it:
```
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/simplicity_studio/
docker build -t simplicity_studio:latest .
```

## Run
First run the `xhost` command to give local `root` user acess to the X server.
```
xhost SI:localuser:root
```
Then run the new container.
```
docker run -it --rm --privileged \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/bus/usb:/dev/bus/usb \
-e DISPLAY=unix$DISPLAY \
simplicity_studio
```

## Use
Run DesktopEditors from the container.
```
studio
```
