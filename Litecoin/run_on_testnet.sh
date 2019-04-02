#!/bin/sh
CONFIG_FILE="litecoin.conf"
RPCAUTH=false
PARAMS=" -testnet -rpcallowip=172.17.0.0/16"
while test $# -gt 0
do
case "$1" in
	-v) VERSION="$2"
		echo "Setting version to "${VERSION}
	;;
	-build) echo "building..."
		if [ -z "$VERSION" ]
		then
			docker build -t nemesgyadam/litecoin-core .
		else
			docker build -t nemesgyadam/litecoin-core --build-arg LITECOIN_VERSION=${VERSION} .
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


sudo chown ${USER} ~/.litecoin
if [ "$RPCAUTH" = false ]
then
	if [ -f "$CONFIG_FILE" ]
	then
		echo "Loading config file..."
	else
		echo "Config file not found,creating ..."
		echo "rpcuser=cointaner"
		echo "rpcpass=bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM="
		echo "rpcuser=cointaner \nrpcpassword=bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=" > ${CONFIG_FILE}
	fi
	cp ${CONFIG_FILE} ~/.litecoin/${CONFIG_FILE}
	
else
	echo "Using RPCAuth..."

fi
echo "Starting litecoin testnet node..."
docker run -v ~/.litecoin:/root/.litecoin -d --network="host" --rm --name litecoin-core-testnet nemesgyadam/litecoin-core${PARAMS}
