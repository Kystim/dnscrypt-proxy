default: build

build:
	docker build \
    -t kystim/dnscrypt-proxy \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .

run:
	docker run -d -p "[::1]:53:53" kystim/dnscrypt-proxy

stop:
	docker stop $(docker ps | grep kystim/dnscrypt-proxy | awk '{print $1}')

rm:
	docker rm $(docker ps -a | grep kystim/dnscrypt-proxy | awk '{print $1}')

up:
	docker-compose up

down:
	docker-compose down
