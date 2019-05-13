# Description
Capricoin core is a fork from bitcoin core, therefore, you can use the documentation of bitcoin:

The development documentation available on the [Bitcoin Developer Documentation](https://bitcoin.org/en/developer-documentation) website along with its [RPC API Documentation](https://bitcoincore.org/en/doc/).

For more information visit [Capricoin github repository](https://github.com/Capricoinofficial/Capricoin)

## Exposed Port
- 22716  #   Mainnet JSON-RPC/REST port 

## Mount points
│
├── /home/cointainer
│   ├── .capricoin # contains the files of the capricoin core
│   │   ├── testnet3 # contains the files of the capricoin core testnet
│   │   ├── blocks # Contains blockchain data
│   ├── config
│   │   ├── capricoin # cointains configuration file(s) for the capricoin core.
# Usage

Set RPC user and password in config/mainnet_Capricoin.conf 

>./run_on_mainnet.sh

## Example RPC usage

> curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointainer:pCpXJwIE15M3N4I5C4pZFyNmdlNACMykrVQ3OilVf8I=@127.0.0.1:22713

## Example CLI usage
#### Outside docker:

> docker exec capricoin-core-mainnet Capricoind -conf=/home/cointainer/config/capricoin/mainnet_Capricoin.conf getbalance

## Inside docker:

> Capricoind getinfo

    RPC port: 22713
    Capricoin currenty don't have a working tesnet blockchain.
