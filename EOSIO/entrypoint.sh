#!/bin/sh
set -e

keosd &
if [ $# -ne 0 ] ; then
    if [ `echo "$1" | cut -c1` = "-" ] ; then
        echo "Call nodeos with the given arguments: $@"
        set -- nodeos --data-dir /home/cointainer/.eosio/data --genesis-json /home/cointainer/.eosio/genesis.json --config-dir /home/cointainer/.eosio/config "$@"
    else
        exec "$@"
    fi
else
    exec nodeos --data-dir /home/cointainer/.eosio/data --genesis-json /home/cointainer/.eosio/genesis.json --config-dir /home/cointainer/.eosio/config
fi
