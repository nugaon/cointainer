# Description
Litecoin core is a fork from bitcoin core, therefore, you can use the documentatoin of bitcoin:


The development documentation available on the [Ripple Developers](https://developers.ripple.com) website along with its [RPC API Documentation](https://developers.ripple.com/rippled-api.html).


For more information visit [Litecoin github repository](https://github.com/litecoin-project/litecoin)

## Requirements
You can read about the blockchain node requrements [here](https://github.com/litecoin-project/litecoin/issues/409)

# Usage

## Testnet:


>./run_on_testnet.sh


This command will build the litecoin-core docker image-if not exists yet- then run the litecoin-core on testnet.


### Parameters:


-v (default:0.16.3)


-build: build the image even if it already exists


### Litecoind parameters
Or you can pass parameter to litecoind like:

--rescan

--rpcauth='cointainer:58c54af0545a21fd133e8edd7e0de40d$d4192975a4ebdbc4758b7d08e5b8e428dbf0434ef9c09b0d5da95e592e385a86'

    (if no rpcauth is set the script will try to use user/password from litecoin.conf)
    (if no litecoin.conf is found the script will create one with the below user/pass -testnet only)
### Example:


> ./run_on_testnet.sh -v 0.16.0 -build --rescan


    Test RPC port: 19332
    RPC Username: cointainer
    RPC Password: pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=


To withdraw some test coins to your account, you can use [this site](https://faucet.thonguyen.net/ltc)



### Example RPC usage

> curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointainer:pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=@127.0.0.1:19332


### Example CLI usage
#### Outside docker:

>docker exec -it litecoin-core-testnet litecoin-cli -testnet getmininginfo


#### Inside docker:

>litecoin-cli -testnet getmininginfo


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

### Example:



> ./run_on_mainnet.sh -v 0.16.0 -build --rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc')


### Example RPC usage

>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://foo:qDDZdeQ5vw9XXFeVnXT4PZ--tGN2xNjjR4nrtyszZx0=@127.0.0.1:9332

### Example CLI usage
#### Outside docker:

>docker exec -it litecoin-core-testnet litecoin-cli getmininginfo


#### Inside docker:

>litecoin-cli getmininginfo


    RPC port: 9332
    Testnet and mainnet use the same docker image.
    chmod +x run_on_...net.sh if necessery
