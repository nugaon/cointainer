#!/bin/sh
while test $# -gt 0
do
    case "$1" in
        --v) VERSION="$2"
			 echo "Setting version to "${VERSION}
            ;;
        --build) echo "building..."
				if [ -z "$VERSION" ]
					then
					docker build -t nemesgyadam/litecoin-core .
				else
					docker build -t nemesgyadam/litecoin-core --build-arg LITECOIN_VERSION=${VERSION} .
				fi
            ;;
        --*) echo "bad option $1"
            ;;
        
    esac
    shift
	done
if [ -z $(docker images -q nemesgyadam/litecoin-core) ] 
then
	echo "Can't find image, building..."
	if [ -z "$VERSION" ]
					then
					docker build -t nemesgyadam/coin-core .
				else
					docker build -t nemesgyadam/litecoin-core --build-arg LITECOIN_VERSION=${VERSION} .
				fi
	fi
docker run -v /home/ubuntu/.litecoin:/home/ubuntu/.litecoin -d -p 9332:9332 --rm --name litecoin-core nemesgyadam/litecoin-core -rpcallowip=172.17.0.0/16 -rpcallowip=172.17.0.0/16 -rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc'

