#!/bin/sh
NET="mainnet" 
CONFIG_FILE="bitcoin.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -f ${SCRIPTPATH}/config/${CONFIG_FILE} ] ; then 
	echo "Copying sample config file into ./config/${CONFIG_FILE}, because it didn't exist";
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${CONFIG_FILE}; 
else
	read -p "The configuration already set bitcoin.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${CONFIG_FILE}; echo "Copying sample config file..."; break;; 
			[Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Bitcoin node on ${NET}" 
echo "chown ownership of the config folder to 999 with command: sudo chown 999 -R ./config"
sudo -k chown 999 -R ${SCRIPTPATH}/config

docker run -d -v ${SCRIPTPATH}/config:/home/cointainer/.bitcoin/ -p 127.0.0.1:8332:8332  --name bitcoin-core-${NET} cointainer/bitcoin-core $@
