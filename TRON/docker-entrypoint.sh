#!/bin/sh
# script call structure: ./docker-entrypoint.sh --nettype [nodetype] [args]
# script call example: ./docker-entrypoint.sh --nettype main --fullhttpport 8888 --solhttpport 9999
set -e

BASIC_PARAMS="-c /tron-data/config.conf --output-directory /tron-data/"
if [ "$1" = "fullnode" ] ; then
    echo "$1 server is starting..."
    PARAMS=`echo "$@" | awk '{$1=""; print $0}'`

    java -jar /tron/tron_nodes/fullnode/full.jar $BASIC_PARAMS $PARAMS
else
    echo "The first passed parameter is not a node type."
    $@
fi
