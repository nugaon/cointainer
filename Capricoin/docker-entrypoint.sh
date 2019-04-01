#!/bin/sh
set -e
if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for capricoind"
  
  set -- Capricoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "Capricoind" ]; then
  mkdir -p "$CAPRICOIN_DATA"
 
  echo "$0: setting data directory to $CAPRICOIN_DATA"

  set -- "$@" -datadir="$CAPRICOIN_DATA"
fi

chmod +x /Capricoind

echo
exec /"$@"

