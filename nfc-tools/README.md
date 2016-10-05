# NFC Tools Docker image

Automatically builds an environment with the following tools:

* mfoc
* libnfc-bin

## Build
```
$ docker build -t mynfctools:latest .
```

## Run
```
$ docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb mynfctools
```
