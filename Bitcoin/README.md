# Description
The development documentation available on the [Bitcoin Developer Documentation](https://bitcoin.org/en/developer-documentation) website along with its [RPC API Documentation](https://bitcoincore.org/en/doc/).

## Requirements
You can read about the blockchain node requrements [here](https://bitcoin.org/en/bitcoin-core/features/requirements)


## Exposed Ports
- 8332  #   Mainnet JSON-RPC/REST port
- 8333  #   Mainnet P2P port
- 18332 #   Testnet JSON-RPC/REST port
- 18333 #   Testnet P2P port
- 18443 #   Regtest JSON-RPC/REST port
- 18444 #   Regtest P2P port


## Mount Binding
host
│
├── /home/[USER]  
│   ├── .bitcoin # contains the files of the bitcoin core
│   │   ├── testnet3 # contains the files of the bitcoin core testnet
│   |   ├── .config
│   │   ├── blocks # Contains blockchain data


docker
│
├── /home/cointainer
│   ├── .bitcoin # contains the files of the bitcoin core
│   │   ├── testnet3 # contains the files of the bitcoin core testnet
│   |   ├── .config
│   │   ├── blocks # Contains blockchain data

## Usage on live bitcoin blockchain:

### Method 1
Set RPC user and password in config/bitcoin.conf 

>./run_on_mainnet.sh

### Method 2

Generate RPCAuth by:
>curl -sSL https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py python - \<username>



>./run_on_mainnet.sh -rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc'

    
    All command-line options (except for -conf) may be specified in a configuration file, and all configuration file options may also be specified on the command line. Command-line options override values set in the configuration file.


### Example RPC usage
>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://foo:qDDZdeQ5vw9XXFeVnXT4PZ--tGN2xNjjR4nrtyszZx0=@127.0.0.1:8332

### Example CLI usage
#### Outside docker:

>docker exec -it bitcoin-core-testnet bitcoin-cli getmininginfo


#### Inside docker:

>bitcoin-cli getmininginfo

    CLI uses cookie based authenticaion, so doesn't require username/password, but it only works localy.

## Testnet:


>./run_on_testnet.sh -rpcauth='cointainer:58c54af0545a21fd133e8edd7e0de40d$d4192975a4ebdbc4758b7d08e5b8e428dbf0434ef9c09b0d5da95e592e385a86'
    (if no rpcauth is set the script will use the settings from bitcoin.conf)

### Notes
    Testnet RPC Username: cointainer
    Testnet RPC Password: pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=


    Testnet and mainnet use the same docker image.

    chmod +x run_on_...net.sh if necessery

To withdraw some test coins to your account, you can use [here](https://coinfaucet.eu/en/btc-testnet/).
