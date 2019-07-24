#!/bin/sh
set -e
if [ $# -ne 0 ] ; then
    if [ `echo "$1" | cut -c1` = "-" ] ; then
        echo "Call dogecoind with the given arguments: $@"
        set -- dogecoind "$@"
    else
        exec "$@"
    fi
else
    exec dogecoind
fi
