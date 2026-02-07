# NFC Tools Docker image

[![Docker Build](https://img.shields.io/docker/cloud/build/andremiras/nfc-tools)](https://hub.docker.com/r/andremiras/nfc-tools)

Automatically builds an environment with the following tools:

* [libnfc](https://github.com/nfc-tools/libnfc)
* [mfoc](https://github.com/nfc-tools/mfoc)
* [mfcuk](https://github.com/nfc-tools/mfcuk)
* [RFIDIOt](https://github.com/AdamLaurie/RFIDIOt)

## Run
```
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb andremiras/nfc-tools
```

## Usage example
Run your favorite nfc tool.
```
mfoc -O /tmp/mycard.mfd
```
Then copy the `mycard.mfd` output file to your host current directory using `docker cp`.
```
docker cp <CONTAINER>:/tmp/mycard.mfd ./
```

## Build
Automatically clone and build:
```
docker build -t nfc-tools https://github.com/AndreMiras/dockerfiles.git#main:nfc-tools
```
Or clone it yourself, then build it:
```
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/nfc-tools/
docker build -t nfc-tools .
```
