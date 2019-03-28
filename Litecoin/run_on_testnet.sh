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
        
esac
shift
done

if [ -z $(docker images -q nemesgyadam/litecoin-core) ] 
then
	echo "Can't find image, building..."
	if [ -z "$VERSION" ]
					then
					docker build -t nemesgyadam/litecoin-core .
				else
					docker build -t nemesgyadam/litecoin-core --build-arg LITECOIN_VERSION=${VERSION} .
				fi
	fi
echo "Starting testnet node..."
docker run -v /home/ubuntu/.litecoin:/home/ubuntu/.litecoin -d -p 19332:19332 --rm --name litecoin-core-testnet nemesgyadam/litecoin-core -testnet  -rpcallowip=172.17.0.0/16 -rpcauth='cointaner:d941010ee4d66ccf4ad96d757fa4773d$17f5c4a49dd3097c03049223cd9f2d493271cfa2e1e44ac6e1f72d39fbf75abf'

