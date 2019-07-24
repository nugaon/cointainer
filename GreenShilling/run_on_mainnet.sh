#!/bin/sh
NET="mainnet"
CONFIG_FILE="GreenShilling.conf"
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
CONFIG_DIR="${SCRIPT_PATH}/config/mainnet"
CONFIG_SAMPLE_PATH="${SCRIPT_PATH}/greenshilling-${NET}-sample.conf"
PARAMS=""

if [ ! -f ${CONFIG_DIR}/${CONFIG_FILE} ] ; then
	if [ ! -d ${CONFIG_DIR} ] ; then
		mkdir -p ${CONFIG_DIR}
	fi
	echo "Copying sample config file into ${CONFIG_DIR}/${CONFIG_FILE}, because it didn't exist";
	cp ${CONFIG_SAMPLE_PATH} ${CONFIG_DIR}/${CONFIG_FILE}
else
	read -p "The configuration already set to ${CONFIG_FILE}. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) sudo cp ${CONFIG_SAMPLE_PATH} ${CONFIG_DIR}/${CONFIG_FILE}; echo "Copying sample config file..."; break;;
			[Nn]* ) echo "Loading config file..."; break;;
			* )	echo "Please answer y or n.";;
		esac
	done
fi

sudo chmod 600 ${CONFIG_DIR}/${CONFIG_FILE}
sudo chown -R 999:999 config

echo "Run GreenShilling node on ${NET}"
docker run -d -v ${CONFIG_DIR}:/home/cointainer/.GSL --network host --name greenshilling-${NET} cointainer/greenshilling $PARAMS $@
