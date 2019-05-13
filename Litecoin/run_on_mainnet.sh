#!/bin/sh
NET="mainnet" 
CONFIG_FILE="litecoin.conf"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PARAMS=" -testnet -conf=/home/cointainer/config/litecoin/${NET}_${CONFIG_FILE}"


if [ ! -f ${SCRIPTPATH}/config/${CONFIG_FILE} ] ; then
        echo "Copying sample config file into ./config/${CONFIG_FILE}, because it didn't exist";
        cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${CONFIG_FILE};
else
        read -p "The configuration already set in litecoin.conf. Do you want to replace it by the sample ${NET} configuration? (y or n): " yn
        while true; do
                case $yn in
                        [Yy]* ) cp ${SCRIPTPATH}/${CONFIG_FILE}-${NET}.example ${SCRIPTPATH}/config/${CONFIG_FILE}; echo "Copying sample config file..."; break;;
                        [Nn]* ) echo "Loading config file..."; break;;
                        * ) echo "Please answer y or n.";;
                esac
        done
fi
echo "Run litecoin node on ${NET}"
docker run -d -v ${SCRIPTPATH}/config:/home/cointainer/.litecoin/ --network host --name litecoin-core-${NET} cointainer/litecoin-core${PARAMS} $@

