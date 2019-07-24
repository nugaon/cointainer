#!/bin/sh

NET="testnet"
CONFIG_FILE="dogecoin.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_USER_ID=1999
CONFIGPATH=${SCRIPTPATH}/config/${NET}

if [ ! -d $CONFIGPATH ] ; then
    mkdir $CONFIGPATH
fi

if [ ! -f $CONFIGPATH/${CONFIG_FILE} ] ; then
	echo "Copying sample config file into ${CONFIGPATH}, because it didn't exist";
	cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example $CONFIGPATH/${CONFIG_FILE};
else
	read -p "The configuration already set ${CONFIG_FILE}. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example $CONFIGPATH/${CONFIG_FILE}; echo "Copying sample config file..."; break;;
			[Nn]* ) echo "Loading config file..."; break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
echo "Run Dogecoin node on ${NET}"
echo "chown ownership of the config folder to ${CONTAINER_USER_ID} with command: sudo chown ${CONTAINER_USER_ID} -R ${CONFIGPATH}"
sudo -k chown ${CONTAINER_USER_ID} -R $CONFIGPATH

docker run -d -v $CONFIGPATH:/home/cointainer/.dogecoin/ -p 127.0.0.1:44555:44555 -p 0.0.0.0:44556:44556 --name dogecoin-${NET} cointainer/dogecoin $@
