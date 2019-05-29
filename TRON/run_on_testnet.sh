#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NET="testnet"
NODE="fullnode"
CONFIG_DIR=${SCRIPT_PATH}/config/${NET}

if [ ! -d $CONFIG_DIR ] ; then
    mkdir $CONFIG_DIR
fi

if [ ! -f $CONFIG_DIR/config.conf ] ; then
    echo "No configuration file exists at $CONFIG_DIR/config.conf. Set the default configuration..."
    cp tron-${NET}-sample.conf $CONFIG_DIR/config.conf
fi
docker run -v ${CONFIG_DIR}:/tron-data/ -d --name tron-${NODE}-${NET} -p 127.0.0.1:8090:8090 testtron fullnode
