#!/bin/sh
CONFIG_FILE="bitcoin.conf"
RPCAUTH=false
PARAMS=" -testnet -rpcallowip=172.17.0.0/16 -deprecatedrpc=accounts -deprecatedrpc=signrawtransaction "
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
		echo "Config file not found,creating ..."
		echo "rpcuser=cointaner"
		echo "rpcpass=bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM="
		echo "rpcuser=cointaner\nrpcpassword=bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=\nrpcallowip=127.0.0.1\nenableaccounts=1\nstaking=0" > ${CONFIG_FILE}
	fi
	cp ${CONFIG_FILE} ~/.bitcoin/${CONFIG_FILE}
	
else
	echo "Using RPCAuth..."

fi
echo "Starting bitcoin testnet node..."
docker run -d -v ~/.bitcoin:/root/.bitcoin -p 127.0.0.1:18332:18332 --rm --name bitcoin-core-testnet nemesgyadam/bitcoin-core${PARAMS}
