# Buildozer Docker image

Docker image for building Android APKs via [Buildozer](https://github.com/kivy/buildozer).

## Build
Automatically clone and build:
```sh
docker build -t buildozer:latest https://github.com/AndreMiras/dockerfiles.git#master:buildozer
```
Or clone it yourself, then build it:
```sh
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/buildozer/
docker build -t buildozer:latest .
```

## Run
Run the new container in interactive mode.
```sh
docker run -it --rm --privileged buildozer
```
Then run buildozer from the container.
```sh
buildozer android debug
```

Or directly execute the command and exit.
```sh
docker run --privileged buildozer \
'buildozer android debug'
```