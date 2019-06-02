#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NET="mainnet"
DOCKER_NET="tron-${NET}"
HTTPPORT=

if ! docker node ls ; then
    echo "This solution requires your host be in a Docker swarm."
    exit 1
fi

if ! docker network inspect $DOCKER_NET > /dev/null ; then
    docker network create $DOCKER_NET
fi

while true; do
    read -p "What type of node do you want to setup? (fullnode | soliditynode) " NODE
    case $NODE in
        fullnode ) NODE=$NODE; HTTPPORT=8090; break;;
        soliditynode ) NODE=$NODE; HTTPPORT=8091; break;;
        * ) echo "Please answer 'fullnode' or 'soliditynode'";;
    esac
done


CONFIG_DIR=${SCRIPT_PATH}/config/${NET}/${NODE}

if [ ! -d $CONFIG_DIR ] ; then
    mkdir -p $CONFIG_DIR
fi

if [ ! -f $CONFIG_DIR/config.conf ] ; then
    echo "No configuration file exists at $CONFIG_DIR/config.conf. Set the default configuration..."
    cp tron-${NET}-sample.conf $CONFIG_DIR/config.conf
    if [ $NODE != "fullnode" ] ; then
        sed -i "s/trustNode = \"127.0.0.1:50051\"/trustNode = \"tron-fullnode-${NET}:50051\"/" $CONFIG_DIR/config.conf
    fi
fi

docker run -v ${CONFIG_DIR}:/tron-data/${NODE} -d --name tron-${NODE}-${NET} --network $DOCKER_NET -p 127.0.0.1:$HTTPPORT:$HTTPPORT cointainer/tron $NODE
