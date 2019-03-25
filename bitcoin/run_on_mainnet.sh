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
docker run -v /home/ubuntu/bitcoin:/home/ubuntu/bitcoin -d --rm -p 8332:8332 --name bitcoin-node nemesgyadam/bitcoin-core  -rpcallowip=172.17.0.0/16 -rpcauth='nemes:762008f3357fb7ed19864d632f62701e$19685dea44164627fd3277feeac445e2ef52002b816441ad531b92db9fd5232e'
