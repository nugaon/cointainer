# Description
Litecoin core is a fork from bitcoin core, therefore, you can use the documentation of bitcoin:

The development documentation available on the [Bitcoin Developer Documentation](https://bitcoin.org/en/developer-documentation) website along with its [RPC API Documentation](https://bitcoincore.org/en/doc/).

For more information visit [Litecoin github repository](https://github.com/litecoin-project/litecoin)

## Requirements
You can read about the blockchain node requrements [here](https://github.com/litecoin-project/litecoin/issues/409)

## Exposed Ports
- 9332  #   Mainnet JSON-RPC/REST port  
- 9333  #   Mainnet P2P port
- 19332 #   Testnet JSON-RPC/REST port  
- 19333 #   Testnet P2P port


## Mount points
│
├── /home/cointainer
│   ├── .litecoin # contains the files of the litecoin core
│   │   ├── testnet4 # contains the files of the litecoin core testnet
│   │   ├── blocks # Contains blockchain data
│   ├── config
│   │   ├── litecoin # cointains configuration file(s) for the litecoin core.

## Usage on Live litecoin blockchain:

### Method 1
Set RPC user and password in config/mainnet_litecoin.conf 

>./run_on_mainnet.sh

### Method 2

Generate RPCAuth by:
>curl -sSL https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py python - \<username>




>./run_on_mainnet.sh -rpcauth='cointainer:58c54af0545a21fd133e8edd7e0de40d$d4192975a4ebdbc4758b7d08e5b8e428dbf0434ef9c09b0d5da95e592e385a86'



    All command-line options (except for -conf) may be specified in a configuration file, and all configuration file options may also be specified on the command line. Command-line options override values set in the configuration file.




### Example RPC usage

>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointainer:pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=@127.0.0.1:9332

### Example CLI usage
#### Outside docker:

>docker exec -it litecoin-core-mainnet litecoin-cli getmininginfo


#### Inside docker:

>litecoin-cli getmininginfo


    RPC port: 9332
    Testnet and mainnet use the same docker image.
    chmod +x run_on_...net.sh if necessery

## Testnet:

>./run_on_testnet.sh -rpcauth='cointainer:58c54af0545a21fd133e8edd7e0de40d$d4192975a4ebdbc4758b7d08e5b8e428dbf0434ef9c09b0d5da95e592e385a86'
    
    (if no rpcauth is set the script will use the settings from testnet_litecoin.conf)

## Get block chain info
To check in which blockchain you are on and read more details run the following command:

### Curl
>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getblockchaininfo","params":[]}' http://cointainer:pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=@127.0.0.1:9332

(or in testnet:)

>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getblockchaininfo","params":[]}' http://cointainer:pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=@127.0.0.1:19332

### CLI
>docker exec -it litecoin-core-mainnet litecoin-cli -conf=/home/cointainer/config/litecoin/mainnet_litecoin.conf getblockchaininfo

(or in testnet:)

>docker exec -it litecoin-core-testnet litecoin-cli -testnet -conf=/home/cointainer/config/litecoin/testnet_litecoin.conf getblockchaininfo

To withdraw some test coins to your account, you can use [this site](https://faucet.xblau.com/).
