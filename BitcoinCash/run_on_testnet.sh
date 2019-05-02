#!/bin/sh
NET="testnet" 
CONFIG_FILE="bitcoinCash.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -f ${SCRIPTPATH}/config/bitcoin.conf ] ; then 
	echo "Copying sample config file into ./config/bitcoin.conf, because it didn't exist";
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/bitcoin.conf; 
else
	read -p "The configuration already set in bitcoin.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/bitcoin.conf; echo "Copying sample config file..."; break;; 
			[Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Bitcoin node on ${NET}"
echo "chown ownership of the config folder to 999 with command: sudo chown 999 -R ./config"
sudo -k chown 999 -R ${SCRIPTPATH}/config

docker run -d -v ${SCRIPTPATH}/config:/home/cointainer/.bitcoin -p 127.0.0.1:18332:18332 --name bitcoincash-core-${NET} cointainer/bitcoincash-core $@
