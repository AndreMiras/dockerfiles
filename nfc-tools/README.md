# NFC Tools Docker image

Automatically builds an environment with the following tools:

* [libnfc](https://github.com/nfc-tools/libnfc)
* [mfoc](https://github.com/nfc-tools/mfoc)
* [mfcuk](https://github.com/nfc-tools/mfcuk)
* [RFIDIOt](https://github.com/AdamLaurie/RFIDIOt)

## Build
Automatically clone and build:
```
docker build -t mynfctools:latest https://github.com/AndreMiras/dockerfiles.git#master:nfc-tools
```
Or clone it yourself, then build it:
```
https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/nfc-tools/
docker build -t mynfctools:latest .
```

## Run
```
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb mynfctools
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
