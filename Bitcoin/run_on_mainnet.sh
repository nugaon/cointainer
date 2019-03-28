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
					docker build -t nemesgyadam/bitcoin-core .
				else
					docker build -t nemesgyadam/bitcoin-core --build-arg BITCOIN_VERSION=${VERSION} .
				fi
            ;;
        --*) echo "bad option $1"
            ;;
        
    esac
    shift
	done
if [ -z $(docker images -q nemesgyadam/bitcoin-core) ] 
then
	echo "Can't find image, building..."
	if [ -z "$VERSION" ]
					then
					docker build -t nemesgyadam/bitcoin-core .
				else
					docker build -t nemesgyadam/bitcoin-core --build-arg BITCOIN_VERSION=${VERSION} .
				fi
	fi
docker run -v /home/ubuntu/bitcoin:/home/ubuntu/bitcoin -d --rm -p 8332:8332 --name bitcoin-node nemesgyadam/bitcoin-core  -rpcallowip=172.17.0.0/16 -rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc' -deprecatedrpc=signrawtransaction -deprecatedrpc=accounts
