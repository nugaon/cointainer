#!/bin/sh
# script call structure: ./docker-entrypoint.sh --nettype [nodetype] [args]
# script call example: ./docker-entrypoint.sh --nettype main --fullhttpport 8888 --solhttpport 9999
set -e

PARAMS=`echo "$@" | awk '{$1=""; print $0}'`
echo "$1 server is starting..."
NODE="$1"

define_output_durectory_in_basic_params () {
    if [ ! -d $OUTPUT_DIR ] ; then
        mkdir -p $OUTPUT_DIR
    fi
    BASIC_PARAMS="-c $OUTPUT_DIR/config.conf --output-directory $OUTPUT_DIR"
}

if [ "$NODE" = "fullnode" ] ; then
    define_output_durectory_in_basic_params

    java -jar /tron/tron_nodes/fullnode/full.jar $BASIC_PARAMS $PARAMS
elif [ "$NODE" = "soliditynode" ] ; then
    define_output_durectory_in_basic_params

    java -jar /tron/tron_nodes/soliditynode/solidity.jar $BASIC_PARAMS $PARAMS
else
    echo "The first passed parameter is not a node type."
    $@
fi
