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
echo "Starting testnet node..."
docker run -v /home/ubuntu/bitcoin:/home/ubuntu/bitcoin -d --rm -p 18332:18332 --name bitcoin-node-testnet nemesgyadam/bitcoin-core -testnet=1 -rpcallowip=172.17.0.0/16 rpcauth='cointaner:d941010ee4d66ccf4ad96d757fa4773d$17f5c4a49dd3097c03049223cd9f2d493271cfa2e1e44ac6e1f72d39fbf75abf' -deprecatedrpc=signrawtransaction -deprecatedrpc=accounts
