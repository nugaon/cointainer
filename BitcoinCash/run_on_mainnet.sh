#!/bin/sh
NET="mainnet" 
CONFIG_FILE="bitcoinCash.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PARAMS=" -conf=/home/cointainer/config/bitcoincash/${NET}_${CONFIG_FILE}"


if [ ! -f ${SCRIPTPATH}/config/${NET}_${CONFIG_FILE} ] ; then 
	echo "Copying sample config file into ./config/{$NET}_${CONFIG_FILE}, because it didn't exist";
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${NET}_${CONFIG_FILE}; 
else
	read -p "The configuration already set in ${NET}_bitcoinCash.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${NET}_${CONFIG_FILE}; echo "Copying sample config file..."; break;; 
			[Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Bitcoin node on ${NET}" 
docker run -d -v bitcoincash:/home/cointainer/.bitcoin/ -v ${SCRIPTPATH}/config:/home/cointainer/config/bitcoincash -p 127.0.0.1:8442:8332  --name bitcoincash-core-${NET} cointainer/bitcoincash-core${PARAMS} $@
