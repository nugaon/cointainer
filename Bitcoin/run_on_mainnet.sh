#!/bin/sh
NET="mainnet" 
CONFIG_FILE="bitcoin.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PARAMS=" -conf=/home/cointainer/config/bitcoin/${NET}_${CONFIG_FILE} "


if [ ! -f ${SCRIPTPATH}/config/${NET}_${CONFIG_FILE} ] ; then 
	echo "Copying sample config file into ./config/{$NET}_${CONFIG_FILE}, because it didn't exist";
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${NET}_${CONFIG_FILE}; 
else
	read -p "The configuration already set in  ${NET}_bitcoin.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${NET}_${CONFIG_FILE}; echo "Copying sample config file..."; break;; 
			[Nn]* ) echo "Loading config file..."; break;;
			* )	echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Bitcoin node on ${NET}" 
docker run -d -v bitcoin:/home/cointainer/.bitcoin/ -v ${SCRIPTPATH}/config:/home/cointainer/config/bitcoin -p 127.0.0.1:8332:8332  --name bitcoin-core-${NET} cointainer/bitcoin-core${PARAMS} $@
