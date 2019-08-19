#!/bin/sh
set -e

NODE_VOLUME=/home/cointainer/.eosio
CONFIGPATH=${NODE_VOLUME}/config
DATAPATH=${NODE_VOLUME}/data
WALLETPATH=${NODE_VOLUME}/wallet

if [ ! -d $CONFIGPATH ] ; then
    mkdir -p $CONFIGPATH
fi
if [ ! -d $DATAPATH ] ; then
    mkdir -p $DATAPATH
fi
if [ ! -d $WALLETPATH ] ; then
    mkdir -p $WALLETPATH
fi

keosd --config-dir $WALLETPATH --data-dir $WALLETPATH &
if [ $# -ne 0 ] ; then
    if [ `echo "$1" | cut -c1` = "-" ] ; then
        echo "Call nodeos with the given arguments: $@"
        exec nodeos --data-dir /home/cointainer/.eosio/data --config-dir /home/cointainer/.eosio/config "$@"
    else
        exec "$@"
    fi
else
    exec nodeos --data-dir /home/cointainer/.eosio/data --config-dir /home/cointainer/.eosio/config
fi
