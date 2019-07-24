# Description
Dogecoin is a decentralized, peer-to-peer digital currency that enables you to easily send money online. Think of it as "the internet currency."
What's with Dogecoin and the dog?
"Doge" is our fun, friendly mascot! The Shiba Inu is a Japanese breed of dog that was popularized as an online meme and represents Dogecoin.
Fore more information visit the [official page](https://dogecoin.com/)

Dogecoin is a fork from bitcoin core, therefore, you can use the documentation of bitcoin:

The development documentation available on the [Bitcoin Developer Documentation](https://bitcoin.org/en/developer-documentation) website along with its [RPC API Documentation](https://bitcoincore.org/en/doc/).

The image runs by default the [dogecoind daemon](https://github.com/dogecoin/dogecoin/releases/download/v1.14.0/dogecoin-1.14.0-x86_64-linux-gnu.tar.gz). The latest built version is 1.14 x86_64 version.
If you want to upgrade the version before the new Cointainer release, change the version number in the Dockerfile and build the image yourself.

Search for transactions block on [one its explorer](https://chain.so/DOGE)

## Exposed Port
- 22555 # Dogecoin RPC port
- 22556 # Dogecoin P2P port
- 44555 # Dogecoin RPC TEST port
- 44556 # Dogecoin P2P TEST port

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

## Faucet for free Testnet coins

To get free coins visit [this page, who offers free coins on the testnet](https://doge-faucet-testnet.ggcorp.fr/)

To The MooOON!!
