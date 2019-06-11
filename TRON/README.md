# Description
TRON is an ambitious project dedicated to the establishment of a ** truly decentralized Internet ** and its infrastructure. The TRON Protocol, one of the largest blockchain based operating systems in the world, offers base public blockchain support of high throughput, high scalability, and high availability for all decentralized applications in the TRON ecosystem.
For exchanges necessary to run a FullNode and a SolidityNode.

## Configuration
The sample configuration  files originally come from the [official TRON Git repository](https://github.com/tronprotocol/tron-deployment), but it is altered.

## Requirements
- minimum 2 cores CPU, suggested 4 cores for full node
- 64 cores for Super Representative

The Requirements varies in the official documentations, the [GitHub of the protocol Requirements sections](https://github.com/tronprotocol/documentation/blob/master/TRX/Tron-overview.md#31-recommended-hardware-specifications) specifies much more

## Dependencies
- Oracle Java JDK 1.8
The TRON server uses Oracle JDK 8. When build TRON JAR file the OpenJDK versions runs on error, so it cannot be used with the OpenJDK version.
Necessary to run with Oracle JDK, until they make compatible with OpenJDK.
No update, bugfixes or vulnerability fixes will be available after April 2019 on the unlicensed Oracle JDK 8 servers, so use your own responsibility or update directly in your container process.
- Python 3.6+
- MongoDB (for event server)

## Exposed Ports
- 18888 # (TCP) default communication port between TRON nodes [should externally accessible]
- 50051 # RPC port of full node (for API calls)
- 50061 # RPC port of solidity
- 8090  # HTTP port of full node
- 8091  # HTTP port of solidity

# Usage
The syncing is very slow and suggested to download the blocks from the [official backup site of TRON](https://backups.trongrid.io/) for the mainnet.
After you downloaded the blocks, place it into the * ./config/mainnet/{nodetype} * folder before you run the * run_on_mainnet.sh * script.
There is opportunity to connect to the testnet (on Shasta), but  they haven't opened the p2p port yet and the sync also very slow, instead of that test everything on the privatenet with the './run_on_privatenet.sh'.

## CLI commands

You can use interactive wallet cli of TRON
> docker exec -ti tron-fullnode-mainnet wallet-cli

## Full Node HTTP API

Read the [official documentation](https://developers.tron.network/reference#wallets-accounts) of HTTP API of the Full Node with all EPs along with other TRON services' documentation.

The most important methods:

Generate account
> curl -X POST -k http://127.0.0.1:8090/wallet/generateaddress

Get last synced block
> curl -X POST  http://127.0.0.1:8090/wallet/getnowblock

### Things that NOT to do

This command overwrite your basic configuration file
> tron-cli config

## Logs
For server logs call (with fullnode on mainnet)
> docker exec -ti tron-fullnode-mainnet tail -f /tron/logs/tron.log

## Mount points


## Testnet
Sashta is the test network's name on the TRON network. Send coin to your address at the * 'Looking for Test (TRX) Coins?' * on the [page of TronGrid](https://www.trongrid.io/shasta/)
