#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bitcoind"

  set -- bitcoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bitcoind" ]; then
  mkdir -p "$BITCOIN_DATA"
 
  echo "$0: setting data directory to $BITCOIN_DATA"

  set -- "$@" -datadir="$BITCOIN_DATA"
fi


echo
exec "$@"