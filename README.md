# docker-nzbget
This is an [nzbget](http://nzbget.net/) docker container.

The easiest way to use this is probably a fig file:
```
nzbget:
  image: stono/nzbget 
  environment:
    nzb_password: "YourNzbPassword"
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
As you can see above, /storage is a persistent volume which you can mount.  If you mount an empty directory the startup script will automatically create:
  - config
  - config/nzbget.conf
  - config/ssl/_certs_
  - dst
  - inter
  - nzb
  - queue
  - scripts
  - tmp

They're all pretty standard from the config.  At the moment, things aren't that configurable, so make sure if you mount a /storage volume where config/nzbget.conf already exists, your directories match those above.
