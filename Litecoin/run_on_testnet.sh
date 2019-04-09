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
			docker build -t cointainer/litecoin-core .
		else
			docker build -t cointainer/litecoin-core --build-arg LITECOIN_VERSION=${VERSION} .
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

if [ -z $(docker images -q cointainer/litecoin-core) ] 
then
	echo "Can't find image, building..."
	if [ -z "$VERSION" ]
	then
		docker build -t cointainer/litecoin-core .
	else
		docker build -t cointainer/litecoin-core --build-arg LITECOIN_VERSION=${VERSION} .
	fi
fi


sudo chown ${USER} ~/.litecoin
if [ "$RPCAUTH" = false ]
then
	if [ -f "$CONFIG_FILE" ]
	then
	read -p "The configuration already set in litecoin.conf. Do you want to replace it by the sample testnet configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) 		
			echo "rpcuser=cointainer\nrpcpassword=pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=\nrpcallowip=127.0.0.1\n" > ${CONFIG_FILE}; break;;
			[Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
	else
		echo "Config file not found,creating ..."
		echo "rpcuser=cointainer"
		echo "rpcpass=pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I="
		echo "rpcuser=cointainer\nrpcpassword=pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=" > ${CONFIG_FILE}

	fi
	cp ${CONFIG_FILE} ~/.litecoin/${CONFIG_FILE}
	
else
	echo "Using RPCAuth..."

fi
echo "Starting litecoin testnet node..."
docker run -v ~/.litecoin:/root/.litecoin -d --network="host" --rm --name litecoin-core-testnet cointainer/litecoin-core${PARAMS}
