# docker-nzbget
This is an [nzbget](http://nzbget.net/) docker container.

The easiest way to use this is probably a fig file:
```
nzbget:
  image: stono/nzbget 
  environment:
    nzb_password: "YourNzbPassword" // If you dont specify a password, one will be generated for you
  volumes:
    - ./storage:/storage
  ports:
    - "80:6789"
    - "443:6791"
```
From there you can start it with `sudo fig up -d` and connect to it on:
  - http://127.0.0.1
  - https://127.0.0.1 (self signed certificate, unique to each container instance)

Or if you don't want to use fig, this will do the job:
```
sudo docker run -d -e="nzb_password=YourNzbPassword" && \
  -v "/home/karl/development/git/github/docker-nzbget/storage:/storage" && \
  -p "80:6789" && \
  -p "443:6791" stono/nzbget
```

## Storage
All config / data gets written to /storage/nzbget on the first "fig up", so if you mount in that volume to somewhere on your system, all your configuration will be preserved through docker container updates.

You could mount in your own, already existing config directory if you like.

## Info 
This is part of a set, all based of the same images, all desgined to eventually piece together.
  - [stono/sonarr](https://github.com/Stono/docker-sonarr) Sonarr in a Docker container
  - [stono/nzbget](https://github.com/Stono/docker-nzbget) NzbGet in a Docker container
  - [stono/couchpotato](https://github.com/Stono/docker-couchpotato) Couchpotato in a docker container
