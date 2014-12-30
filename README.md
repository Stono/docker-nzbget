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
