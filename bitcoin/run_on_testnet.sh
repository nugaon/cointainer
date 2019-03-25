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
docker run -v /home/ubuntu/bitcoin:/home/ubuntu/bitcoin -d --rm -p 18332:18332 --name bitcoin-node-testnet nemesgyadam/bitcoin-core -testnet=1 -rpcallowip=172.17.0.0/16 -rpcauth='nemes:762008f3357fb7ed19864d632f62701e$19685dea44164627fd3277feeac445e2ef52002b816441ad531b92db9fd5232e'
