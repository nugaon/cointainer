#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for litecoind"
  set -- litecoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "litecoind" ]; then
  mkdir -p "$LITECOIN_DATA"
  echo "$0: setting data directory to $LITECOIN_DATA"
  set -- "$@" -datadir="$LITECOIN_DATA"
fi

echo
exec "$@"