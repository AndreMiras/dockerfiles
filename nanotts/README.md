# NanoTTS Docker image

Automatically builds an environment for running [NanoTTS](https://github.com/gmn/nanotts).

## Build
Automatically clone and build:
```
docker build -t nanotts:latest https://github.com/AndreMiras/dockerfiles.git#main:nanotts
```
Or clone it yourself, then build it:
```
git clone https://github.com/AndreMiras/dockerfiles.git
cd dockerfiles/nanotts/
docker build -t nanotts:latest .
```

## Run
Run the new container in interactive mode.
```
docker run -it --rm --privileged nanotts
```
Then run nanotts from the container.
```
nanotts -v fr-FR -w "Bonjour madame"
```

Or directly execute the command and exit.
```
docker run --privileged nanotts \
'nanotts -v fr-FR -w "Bonjour madame"'
```
