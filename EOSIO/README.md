# Description
[EOSIO mainnet config template](https://github.com/CryptoLions/EOS-MainNet/blob/master/config.ini)
EOSIO is a blockchain platform designed for the real world. Built for both public and private use cases, EOSIO is customizable to suit a wide range of business needs across industries with rich role-based security permissions, industry-leading speeds and secure application processing. Building on EOSIO follows familiar development patterns and programming languages used by existing non-blockchain applications so developers can create a seamless user experience using development tools they already know and love.
Fore more information visit the [official page](https://eos.io)

The image runs by default the [nodeos and keosd daemons](https://github.com/EOSIO/eos/releases/download/v1.7.0/eosio_1.7.0-1-ubuntu-18.04_amd64.deb). The uses the version v1.7.0.
If you want to upgrade the version before the new Cointainer release, change the version number in the Dockerfile and build the image yourself.

Search for transactions and blocks on [one its explorer](https://bloks.io/)

## Exposed Port
- 9876  # EOSIO P2P port
- 8888  # EOSIO HTTP port

## Download blocks without syncing
The syncing on the blockchain network is really slow compared to download from a regular block producer which offers to [download its blocks](https://eosnode.tools/blocks) and the owned nodeos server can sync itself from that.

## Mount points
```
│
└── /home/cointainer
    └── .dogecoin # contains the files of dogecoind
        ├── dogecoin.conf # configuration file of the node
        ├── debug.log # daemon log file.
        ├── db.log # database log file.
        ├── wallet.dat # wallet key file, contains your wallet private key
        ├── blocks # contains downloaded blocks from the chain
        |   └── blk[X].dat # Contains block data
        ├── chainstate # A LevelDB database with a compact representation of all currently unspent transaction outputs and some metadata about the transactions they are from.
        └── contains BDB journaling files
```

# Usage

Set RPC user and password in * config/dogecoin.conf *

To run a node on the mainnet, type:
>./run_on_mainnet.sh

## Example CLI usage

Outside docker:

Get balance of the wallet:
> docker exec dogecoin-mainnet dogecoin-cli getbalance

Get info about the network:
> docker exec dogecoin-mainnet dogecoin-cli getblockchaininfo

Create new address in the wallet:
> docker exec dogecoin-mainnet dogecoin-cli getaccountaddress main-deposit-account

Get account addresses:
>  docker exec dogecoin-mainnet dogecoin-cli getaddressesbyaccount main-deposit-account

TO run a node on the testnet, type:
>./run_on_testnet.sh

Curl HTTP example:

Get info about the blockchain exam
> curl --request POST \
  --url http://localhost:8888/v1/chain/get_info \
  --header 'accept: application/json' \
  --header 'content-type: application/json'

Get block
> curl --request POST \
  --url http://localhost:8888/v1/chain/get_block \
  --header 'accept: application/json' \
  --header 'content-type: application/json' \
  --data '{"block_num_or_id":"1000"}'

## Testnet

The available testnet are listen on [the official page, which related to this](https://developers.eos.io/eosio-nodeos/docs/testnets).
The cointainer uses the [Testnet of Telos](https://mon-test.telosfoundation.io/).
For faucet visit [this](https://mon-test.telosfoundation.io/faucet) link.
