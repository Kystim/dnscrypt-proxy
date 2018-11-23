FROM alpine:latest

RUN apk add ca-certificates jq

EXPOSE 53/udp

WORKDIR /etc/dnscrypt-proxy
VOLUME /etc/dnscrypt-proxy

COPY build.sh .

CMD ["./build.sh"]
