# SVOX Pico Docker image

Automatically builds an environment for running [SVOX Pico](https://launchpad.net/ubuntu/+source/svox).

## Build
Automatically clone and build:
```
docker build -t pico2wave:latest https://github.com/AndreMiras/dockerfiles.git#master:pico2wave
```
Or clone it yourself, then build it:
```
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/pico2wave/
docker build -t pico2wave:latest .
```

## Run
Then run the new container.
```
docker run -it --rm --privileged pico2wave
```

## Use
Run pico2wave from the container.
```
pico2wave -l fr-FR -w test.wav "Bonjour madame" && aplay test.wav 
```
