#!/bin/sh

NET="testnet"
CONFIG_FILE="config.ini"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_USER_ID=1999
NODE_VOLUME=${SCRIPTPATH}/nodevol/${NET}
CONFIGPATH=${NODE_VOLUME}/config
DATAPATH=${NODE_VOLUME}/data
WALLETPATH=${NODE_VOLUME}/wallet

if [ ! -d $CONFIGPATH ] ; then
    sudo mkdir -p $CONFIGPATH
fi
if [ ! -d $DATAPATH ] ; then
    sudo mkdir -p $DATAPATH
fi
if [ ! -d $WALLETPATH ] ; then
    sudo mkdir -p $WALLETPATH
fi

if [ ! -f $WALLETPATH/${CONFIG_FILE} ] ; then
	echo "Copying sample config file into ${WALLETPATH}, because it didn't exist";
	sudo cp ${SCRIPTPATH}/config.wallet.ini $WALLETPATH/${CONFIG_FILE};
fi

if [ ! -f $CONFIGPATH/${CONFIG_FILE} ] ; then
	echo "Copying sample config file into ${CONFIGPATH}, because it didn't exist";
	sudo cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example $CONFIGPATH/${CONFIG_FILE};
else
	read -p "The configuration already set ${CONFIG_FILE}. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) sudo cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example $CONFIGPATH/${CONFIG_FILE}; echo "Copying sample config file..."; break;;
			[Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi

if [ ! -f $NODE_VOLUME/genesis.json ] ; then
    sudo cp genesis-${NET}.json $NODE_VOLUME/genesis.json
fi

echo "Run EOSIO node on ${NET}"
echo "chown ownership of the config folder to ${CONTAINER_USER_ID} with command: sudo chown ${CONTAINER_USER_ID} -R ${NODE_VOLUME}"
sudo chown ${CONTAINER_USER_ID} -R $NODE_VOLUME

docker run -d -v $NODE_VOLUME:/home/cointainer/.eosio/ -p 127.0.0.1:8888-8889:8888-8889 -p 0.0.0.0:9876:9876 --name eosio-${NET} cointainer/eosio --genesis-json /home/cointainer/.eosio/genesis.json $@
