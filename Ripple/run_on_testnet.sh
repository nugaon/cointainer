#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
NET="testnet"

echo "Run Ripple node on ${NET}"

if [ ! -f ${SCRIPTPATH}/config/rippled.cfg ] ; then
	echo "Copy sample config into ./config/rippled.cfg, because it wasn't exist"
	cp ${SCRIPTPATH}/rippled-${NET}-sample.cfg ${SCRIPTPATH}/config/rippled.cfg
else
	read -p "The configuration already set in the ./config/rippled.cfg. Do you want to replace it by the working sample ${NET} configuration? (y or n): " yn
	while true; do
		case $yn in
			[Yy]* ) cp ${SCRIPTPATH}/rippled-${NET}-sample.cfg ${SCRIPTPATH}/config/rippled.cfg; break;;
			[Nn]* ) break;;
			* ) echo "Please answer y or n.";;
		esac
	done
fi
if [ ! -f ${SCRIPTPATH}/config/validators.txt ] ; then
        echo "Copy sample config into ./config/validator.txt, because it wasn't exist"
        cp ${SCRIPTPATH}/validators-${NET}-sample.txt ${SCRIPTPATH}/config/validators.txt
else
        read -p "The configuration already set in the ./config/rippled.cfg. Do you want to replace it by the working sample ${NET} configuration? (y or n): " yn
        while true; do
                case $yn in
                        [Yy]* ) cp ${SCRIPTPATH}/validators-${NET}-sample.txt ${SCRIPTPATH}/config/validators.txt; break;;
                        [Nn]* ) break;;
                        * ) echo "Please answer y or n.";;
                esac
        done
fi
docker run -d -p 127.0.0.1:5005:5005 -p 127.0.0.1:6006:6006 -v ${SCRIPTPATH}/config:/home/cointainer/.config/ripple --name ripple-node-${NET} cointainer/ripple:latest $@
