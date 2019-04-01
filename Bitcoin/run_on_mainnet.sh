#!/bin/sh
CONFIG_FILE="bitcoin.conf"
RPCAUTH=false
PARAMS=" -rpcallowip=172.17.0.0/16  -deprecatedrpc=accounts "
while test $# -gt 0
do
case "$1" in
	-v) VERSION="$2"
		echo "Setting version to "${VERSION}
	;;
	-build) echo "building..."
		if [ -z "$VERSION" ]
		then
			docker build -t nemesgyadam/bitcoin-core .
		else
			docker build -t nemesgyadam/bitcoin-core --build-arg BITCOIN_VERSION=${VERSION} .
		fi
	;;
	*-rpcauth*)
		RPCAUTH=true
		PARAM=$( echo $1 | cut -c 2-)
		PARAMS="$PARAMS $PARAM"
	;;
	--*)
		PARAM=$( echo $1 | cut -c 2-)
		
		PARAMS="$PARAMS $PARAM"
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
sudo chown ${USER} ~/.bitcoin
if [ "$RPCAUTH" = false ]
then
	if [ -f "$CONFIG_FILE" ]
	then
		echo "Loading config file..."
	else
		echo "[ERROR] Config file not found. \nPlease create (based on bitcoin.conf.example) and place it next to the Dockerfile\nOr use --rpcauth"
		exit 0
		
	fi
cp ${CONFIG_FILE} ~/.bitcoin/${CONFIG_FILE}
else
	echo "Using RPCAuth..."
fi

echo "Starting bitcoin node..."
docker run -d -v ~/.bitcoin:/root/.bitcoin -p 127.0.0.1:8332:8332 --rm --name bitcoin-core nemesgyadam/bitcoin-core${PARAMS}
