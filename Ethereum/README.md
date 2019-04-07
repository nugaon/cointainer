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

#### Inside docker:</h4>

>bitcoin-cli -testnet getmininginfo


Note: 

    CLI uses cookie based authenticaion, so doesn't require username/password, but it only works localy.

## Live bitcoin blockchain:

<Method 1>

Generate RPCAuth by:
>curl -sSL https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py python - \<username>



>./run_on_mainnet.sh --rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc'


<Method 2>
Create a bitcoin.conf (like bitcoin.conf.example)

>./run_on_mainnet.sh



This command will build the bitcoin-core docker image -if not exists yet- then run the bitcoin-core.

### Parameters:

-v (default:0.17.1)

-build build the image even if it already exists

### Bitcoind parameters
Or you can pass parameter to bitcoind like:

>--rescan

>--rpcauth='cointaner:d941010ee4d66ccf4ad96d757fa4773d$17f5c4a49dd3097c03049223cd9f2d493271cfa2e1e44ac6e1f72d39fbf75abf'
example:

> ./run_on_mainnet.sh -v 0.17.0 -build --rescan

### Example RPC usage
>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:8332

### Example CLI usage
#### Outside docker:</h4>

>docker exec -it bitcoin-core-testnet bitcoin-cli getmininginfo


#### Inside docker:</h4>

>bitcoin-cli getmininginfo

### Notes

RPC port: 8332


Note:  

    Testnet and mainnet use the same docker image.
    chmod +x run_on_...net.sh if necessery
