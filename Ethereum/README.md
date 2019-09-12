# Description
For Ethereum containers it doesn't necessary to write own Dockerfile, because it has official version.

## Used ports
- 8545 # listens on localhost, if you run full node it has websocket server other situations http RPC port.
- 3003 # communication port for Ethereum client nodes
- 3004 # new discovery port for Ethereum clients.

# Usage
All containers persistent storage will be under ~/.ethereum folder on your host.

## Connect to Testnet:
The most used/recommended testnet is Rinkeby on Ethereum. To run a full client on this testnet, run ./run_on_testnet.sh

To get coins visit the following URL: https://www.rinkeby.io/#faucet

### Connect to the geth client

> docker exec -ti ethereum-node-testnet geth attach --datadir=/root/.ethereum/rinkeby/
