#!/bin/bash

echo "This docker image is the official version of the geth"
echo "Run Ethereum geth client on testnet with opened websocket api(8545)..."

docker run -d --name ethereum-node-testnet -v ~/.ethereum:/root/.ethereum \
           -p 127.0.0.1:8545:8545 -p 0.0.0.0:30303:30303 -p 30304:30304 \
           ethereum/client-go:stable \
           --ws --wsapi personal,eth,shh,web3,net \
           --wsport 8545 --wsorigins="*" \
           --wsaddr "0.0.0.0" \
           --syncmode "fast" --cache=1024 --rinkeby 
