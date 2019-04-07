# Usage

## Testnet:


>./run_on_testnet.sh


This command will build the litecoin-core docker image-if not exists yet- then run the litecoin-core on testnet.


### Parameters:


-v (default:0.16.3)


-build: build the image even if it already exists


### Litecoind parameters
Or you can pass parameter to litecoind like:

>--rescan

>--rpcauth='cointaner:d941010ee4d66ccf4ad96d757fa4773d$17f5c4a49dd3097c03049223cd9f2d493271cfa2e1e44ac6e1f72d39fbf75abf'

    (if no rpcauth is set the script will try to use user/password from litecoin.conf)
    (if no litecoin.conf is found the script will create one with the below user/pass -testnet only)
### example:


> ./run_on_testnet.sh -v 0.16.0 -build --rescan


### Notes


Test RPC port: 19332


RPC Username: cointaner


RPC Password: bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=


To withdraw some test coins to your account, you can use the following site:
https://faucet.thonguyen.net/ltc


### Example RPC usage

> curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:19332


### Example CLI usage
#### Outside docker:

>docker exec -it litecoin-core-testnet litecoin-cli -testnet getmininginfo


#### Inside docker:

>litecoin-cli -testnet getmininginfo


Note: 

    CLI uses cookie based authenticaion, so doesn't require username/password, but it only works localy.


## Live litecoin blockchain:

<Method 1>

Generate RPCAuth by:
>curl -sSL https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py python - \<username>




>./run_on_mainnet.sh --rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc'


<Method 2>
Create a litecoin.conf (like litecoin.conf.example)

>./run_on_mainnet.sh


run_on_mainnet.sh will build the litecoin-core docker image -if not exists yet- then run the litecoin-core.


### Parameters:


-v (default:0.16.3)


-build build the image even if it already exists


### Litecoind parameters
Or you can pass parameter to litecoind like:

--rescan

example:


> ./run_on_mainnet.sh -v 0.16.0 -build --rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc')


### Example RPC usage

>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:9332

### Example CLI usage
#### Outside docker:

>docker exec -it litecoin-core-testnet litecoin-cli getmininginfo


#### Inside docker:

>litecoin-cli getmininginfo
### Notes


RPC port: 9332


Note:   

    Testnet and mainnet use the same docker image.

    chmod +x run_on_...net.sh if necessery
