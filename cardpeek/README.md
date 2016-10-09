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
```
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb cardpeek
```

## Use
Run cardpeek from command line.
```
cardpeek
```
