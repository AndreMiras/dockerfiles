# NFC Tools Docker image

Automatically builds an environment with the following tools:

* [libnfc](https://github.com/nfc-tools/libnfc)
* [mfoc](https://github.com/nfc-tools/mfoc)
* [mfcuk](https://github.com/nfc-tools/mfcuk)

## Build
```
$ docker build -t mynfctools:latest .
```

## Run
```
$ docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb mynfctools
```
