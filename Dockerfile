FROM alpine:latest

RUN apk add ca-certificates jq

EXPOSE 53/udp

WORKDIR /etc/dnscrypt-proxy
VOLUME /etc/dnscrypt-proxy

COPY run.sh .

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version "1.0"
LABEL org.label-schema.vcs-ref $VCS_REF
LABEL org.label-schema.vcs-url "https://github.com/Kystim/dnscrypt-proxy"
LABEL org.label-schema.build-date $BUILD_DATE
LABEL org.label-schema.name "kystim/dnscrypt-proxy"
LABEL org.label-schema.description "A lightweight, plug'n play ready, Docker wrapping of [dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy) - big thank you for your great work!"
LABEL org.label-schema.docker.cmd 'docker run -d -p "[::1]:53:53" kystim/dnscrypt-proxy'
LABEL org.label-schema.docker.params "VERSION=Force to use this version instead of the most recent"

CMD ["./run.sh"]
