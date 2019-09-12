# Description
EOSIO is a blockchain platform designed for the real world. Built for both public and private use cases, EOSIO is customizable to suit a wide range of business needs across industries with rich role-based security permissions, industry-leading speeds and secure application processing. Building on EOSIO follows familiar development patterns and programming languages used by existing non-blockchain applications so developers can create a seamless user experience using development tools they already know and love.
Fore more information visit the [official page](https://eos.io)

The image runs by default the [nodeos and keosd daemons](https://github.com/EOSIO/eos/releases/download/v1.7.0/eosio_1.7.0-1-ubuntu-18.04_amd64.deb). The uses the version v1.8.1.
If you want to upgrade the version before the new Cointainer release, change the version number in the Dockerfile and build the image yourself.

Search for transactions and blocks on [one its explorer](https://bloks.io/)

## Exposed Port
- 9876  # EOSIO P2P port
- 8888  # EOSIO HTTP port
- 8889  # EOSIO Wallet service HTTP (keosd)

## Download blocks without syncing
The syncing on the blockchain network is really slow compared to download from a regular block producer which offers to [download its blocks](https://eosnode.tools/blocks) and the owned [nodeos server can sync itself from the backup](https://developers.eos.io/eosio-nodeos/docs/replaying-nodeos). If you wish to take advantage of an existing block log while migrating to a newer version, use `--replay-blockchain` for the first startup.

## State History plugin
In order to properly use the the query functionalities of the nodeos, necessary to use its [state_history_plugin](https://github.com/EOSIO/history-tools).
Cointainer uses [PostgreSQL](https://eosio.github.io/history-tools/database-fillers.html) to save the monitoring of chain, like:
* Header information from each block
* Transaction and action traces, including inline actions and deferred transactions
* Contract table history, at the block level
* Tables which track the history of chain state, including
  * Accounts, including permissions and linkauths
  * Account resource limits and usage
  * Contract code
  * Contract ABIs
  * Consensus parameters
  * Activated consensus upgrades


## Mount points
```
│
└── /home/cointainer
    └── .eosio # contains the files of eosio
        ├── config # contains configuration file of the node
        ├── data # directory containing program runtime data
        |   ├── blocks # downloaded blocks of the blockchain
        |   ├── snapshots # the snapshots about specified blocks' chainstate
        |   └── state # processed state from the blockchain transactions
        ├── wallet # contains kleosd runtime files, its config file and wallet keys
        └── genesis.json # the json object file of the connected blockchain network's genesis block.
```

# Usage

To run a node on the mainnet, type:
>./run_on_mainnet.sh

Suggested to use privatenet instead of testnet for try out the functionalities.

To track and monitor the blockchain on EOSIO network database fillers must be used.
With running the 'run_db_fillers.sh' the Container starts a PostgreSQL db filler with the db server on request.
For the first usage give command with the schema generation flag
>./run_db_fillers.sh --fpg-create

## CLI usage

Through the * cleosd * CLI is possible to query and modify the blockchain data.
To all wallet command should be appended the --wallet-url=unix:///home/cointainer/.eosio/wallet/keosd.sock flag at cleos CLI usage

Outside docker:

Get wallet list:
> docker exec eosio-privatenet cleos --wallet-url=unix:///home/cointainer/.eosio/wallet/keosd.sock wallet list

Get info about the blockchain
> docker exec eosio-privatenet cleos get info

Get commands of the cleos
> docker exec eosio-privatenet cleos

TO run a node on the testnet, type:
>./run_on_testnet.sh

## HTTP/RPC usage

All endpoints and request specification are available in the [official documentation](https://developers.eos.io/eosio-nodeos/reference)

Get info about the blockchain
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

Create wallet (all wallet operation is on the 8889 port by default)
> curl --request POST \
  --url http://127.0.0.1:8889/v1/wallet/create \
  --header 'content-type: application/json' \
  --data '"defa"'

## Testnet

The available testnet are listen on [the official page, which related to this](https://developers.eos.io/eosio-nodeos/docs/testnets).
The cointainer uses the [Testnet of Telos](https://mon-test.telosfoundation.io/).
For faucet visit [this](https://mon-test.telosfoundation.io/faucet) link.

## Privatenet
Every development EOSIO chain has a default system account called "eosio". Its development key the same in your private environment also, and you can import with
> cleos --wallet-url=unix:///home/cointainer/.eosio/wallet/keosd.sock wallet import

When it is asking for the key, pass the following:
`5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3`

# References
[EOSIO mainnet config template](https://github.com/CryptoLions/EOS-MainNet/blob/master/config.ini)
[EOSIO mainnet genesis json](https://github.com/CryptoLions/EOS-MainNet/blob/master/genesis.json)
