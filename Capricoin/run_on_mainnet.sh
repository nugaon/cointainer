#!/bin/sh
CONFIG_FILE="Capricoin.conf"

while test $# -gt 0
do
case "$1" in
    -v) VERSION="$2"
		echo "Setting version to "${VERSION}
    ;;
    -build) echo "building..."
		if [ -z "$VERSION" ]
		then
			docker build -t nemesgyadam/capricoin-core .
		else
			docker build -t nemesgyadam/capricoin-core --build-arg CAPRICOIN_VERSION=${VERSION} .
		fi
	;;
		
	--*)
		PARAM=$( echo $1 | cut -c 2-)
		PARAMS="$PARAMS $PARAM"
	;;
     
esac
shift
done

if [ -z $(docker images -q nemesgyadam/capricoin-core) ] 
then
	echo "Can't find image, building..."
	if [ -z "$VERSION" ]
	then
		docker build -t nemesgyadam/capricoin-core .
	else
		docker build -t nemesgyadam/capricoin-core --build-arg CAPRICOIN_VERSION=${VERSION} .
	fi
fi


sudo chown ${USER} ~/.Capricoin
if [ -f "$CONFIG_FILE" ]
then
	echo "Loading config file..."
else
	echo "[ERROR] Config file not found. Please create (based on Capricoin.conf.example) and place it next to the Dockerfile"
	exit 0
fi
cp ${CONFIG_FILE} ~/.Capricoin/${CONFIG_FILE}
	

echo "Starting capricoin node..."


docker run -d -v ~/.Capricoin:/root/.Capricoin --rm --network host --name capricoin-node nemesgyadam/capricoin-core${PARAMS}
