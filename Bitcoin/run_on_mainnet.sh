#!/bin/sh
CONFIG_FILE="bitcoin.conf"
MOUNTPATH="${HOME}/.bitcoin"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PARAMS=" -conf=/cointainer/.bitcoin/config/${CONFIG_FILE}"
NET="mainnet" 

mkdir -p ${MOUNTPATH}
mkdir -p ${MOUNTPATH}/config
chmod 777 ${MOUNTPATH}

if [ ! -f ${MOUNTPATH}/config/${CONFIG_FILE} ] ; then 
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${MOUNTPATH}/config/${CONFIG_FILE}; echo "Copying sample config file...";
else
	read -p "The configuration already set in bitcoin.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) 		
			 cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${MOUNTPATH}/config/${CONFIG_FILE}; echo "Copying sample config file..."; break;; 
			 [Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Bitcoin node on ${NET}" 
docker run -v ${MOUNTPATH}:/home/cointainer/.bitcoin --network="host" --rm --name bitcoin-core-${NET} cointainer/bitcoin-core${PARAMS} $@
