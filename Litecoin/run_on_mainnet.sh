#!/bin/sh
RPCAUTH=false
CONFIG_FILE="litecoin.conf"
PARAMS=" -rpcallowip=172.17.0.0/16 "
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
		echo "[ERROR] Config file not found. \nPlease create (based on litecoin.conf.example) and place it next to the Dockerfile\nOr use --rpcauth"
		exit 0
		
	fi
cp ${CONFIG_FILE} ~/.bitcoin/${CONFIG_FILE}
else
	echo "Using RPCAuth..."
fi

echo "Starting litecoin node..."
docker run -v ~/.litecoin:/root/.litecoin -d --network="host" --rm --name litecoin-core nemesgyadam/litecoin-core ${PARAMS}


