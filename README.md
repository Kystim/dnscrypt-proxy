This is a lightwight, plug'n play ready, Docker wrapping of [dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy) - big thank you for your great work!

# Usage
## How to run
For host usage:
`docker run -d -p "[::1]:53:53" kystim/dnscrypt-proxy`

## docker-compose.yml

```yaml
version: "3"

services:
  dnscrypt-proxy:
    image: kystim/dnscrypt-proxy:latest
    container_name: dnscrypt-proxy
    ports:
      - "::1:53:53/udp" # make server reachable for host system, but not from outside
#    environment:
#      - VERSION=2.0.18 # optional
```
