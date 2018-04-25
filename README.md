# Socky

Because TCP sockets sock!

## Purpose

You have a bunch of dockerized web services running on your host and have to be
creative about which ports to map on the host so you won't run into conflicts
with existing ones? Socky to the rescue! Run it alongside your webservice, tell
it which host and port to connect to and it will relay the traffic to a unix
socket you can then bind mount to your host.

## Usage

Here's a minimalistic working example docker-compose file:

``` yaml
version: '3.4'
services:
  socky:
    image: jreinert/socky
    environment:
      HOST: web
      PORT: 80
      UID: 1000 # UID of the socket
      GID: 1000 # GID of the socket
      MODE: 660 # User and group have rw permissions, others have none
    volumes:
      - ./web:/run/socky
  web:
    image: nginx
```

And presto! No more unintuitive port juggling! You will find a fresh socket in
`./web/socket`. `proxy_pass http://unix:/path/to/web/socket` in your host's
nginx server block and you're done!
