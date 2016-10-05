# Dockerfiles
Personal Dockerfiles repository

## Build & run example
It's possible to build and run an image without cloning the repository.
Here is an example with the nfc-tools Dockerfile.

### Build
```
docker build -t mynfctools:latest https://rawgit.com/AndreMiras/dockerfiles/master/nfc-tools/Dockerfile
```

### Run
```
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb mynfctools
```
