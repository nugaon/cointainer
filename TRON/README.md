# Description
TRON is an ambitious project dedicated to the establishment of a ** truly decentralized Internet ** and its infrastructure. The TRON Protocol, one of the largest blockchain based operating systems in the world, offers base public blockchain support of high throughput, high scalability, and high availability for all decentralized applications in the TRON ecosystem.

## Configuration
The sample configuration  files originally come from the [official TRON Git repository](https://github.com/tronprotocol/tron-deployment), but it is altered.

## Requirements
- minimum 2 cores CPU, suggested 4 cores for full node
- 64 cores for Super Representative

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

## Full Node HTTP API examples

Get last synced block
> curl -X POST  http://127.0.0.1:8090/wallet/getnowblock

## CLI commands

You can use interactive wallet cli of TRON
> docker exec -ti tron-fullnode-mainnet wallet-cli

## Full Node HTTP API

Read the [official documentation](https://developers.tron.network/reference#wallets-accounts) of HTTP API of the Full Node with all EPs along with other TRON services' documentation.

The most important methods:

Generate account
> curl -X POST -k http://127.0.0.1:8090/wallet/generateaddress

### Things that NOT to do

This command overwrite your basic configuration file
> tron-cli config

## Logs
For server logs call (with fullnode on mainnet)
> docker exec -ti tron-fullnode-mainnet tail -f /tron/logs/tron.log

## Mount points

## Testnet
