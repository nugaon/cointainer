#!/bin/bash

echo "This docker image is the official version of the geth"
echo "The geth client will start in light mode, which means it won't be full node, but it doesn't have to download blocks. It's useful for Mist"
echo "Start geth client in light mode with http based client"

docker run -d --name ethereum-node-light --rm \
		-v ~/.ethereum:/root/.ethereum \
		-v ~/Documents/ethereum:/scripts \
		-p 127.0.0.1:8545:8545 -p 0.0.0.0:30303:30303 -p 30304:30304 \
		ethereum/client-go:stable --rpc --rpcapi personal,eth,shh,web3,net --rpcport 8545 --rpcaddr "0.0.0.0" --syncmode "light"
