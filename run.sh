#!/bin/sh

if [ -z "$VERSION" ]; then
  #Detect latest version
  VERSION=$(wget -qO- https://api.github.com/repos/jedisct1/dnscrypt-proxy/releases/latest | jq --raw-output ".tag_name")
  echo "Latest version is $VERSION"
else
  echo "Forced version is $VERSION"
fi

touch version.txt
CURRENT_VERSION=$(cat version.txt)

#Current version already loaded?
if [ "$VERSION" != "$CURRENT_VERSION" ] || [ ! -f ./dnscrypt-proxy ];then
  #Download and extract tool
  echo "Downloading dnscrypt-proxy version $VERSION"
  wget -qO- "https://github.com/jedisct1/dnscrypt-proxy/releases/download/$VERSION/dnscrypt-proxy-linux_x86_64-$VERSION.tar.gz" \
            | tar xz "linux-x86_64/dnscrypt-proxy" --strip-components 1
  echo "$VERSION" > version.txt
fi

#Download default configuration file but switch from localhost to gobal listening
mkdir -p config
if [ ! -f ./config/dnscrypt-proxy.toml ]; then
  echo "Downloading default configuration file"
  wget -qO- "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-proxy/$VERSION/dnscrypt-proxy/example-dnscrypt-proxy.toml" \
          | sed "s/^\s*listen_addresses[^$]*$/listen_addresses = \['\[::\]:53'\]/g" > ./config/dnscrypt-proxy.toml
fi

./dnscrypt-proxy -config ./config/dnscrypt-proxy.toml
