#!/bin/sh
CONFIG_FILE="bitcoin.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PARAMS="-conf=/home/cointainer/config/bitcoin/${CONFIG_FILE}"
NET="mainnet" 

if [ ! -f ${SCRIPTPATH}/config/${CONFIG_FILE} ] ; then 
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${CONFIG_FILE}; echo "Copying sample config file...";
else
	read -p "The configuration already set in bitcoin.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) 		
			 cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${CONFIG_FILE}; echo "Copying sample config file..."; break;; 
			 [Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Bitcoin node on ${NET}" 
docker run -d -v bitcoin:/home/cointainer/.bitcoin/ -v ${SCRIPTPATH}/config:/home/cointainer/config/bitcoin --network="host" --rm --name bitcoin-core-${NET} cointainer/bitcoin-core${PARAMS} $@
