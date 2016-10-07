# Dockerfiles
Personal Dockerfiles repository

## Build & run example
It's possible to build an image from a remote Dockerfile location and run it.
Here is an example with the nfc-tools Dockerfile.

### Build
Build with cloning:
```
docker build -t mynfctools:latest https://github.com/AndreMiras/dockerfiles.git#master:nfc-tools
```
Build without cloning (won't work with `COPY` commands).
```
docker build -t mynfctools:latest https://rawgit.com/AndreMiras/dockerfiles/master/nfc-tools/Dockerfile
```

### Run
```
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb mynfctools
```
