# Usage

Create a Capricoin.conf file based on the Capricoin_example.conf 

>./run_on_mainnet.sh
(chmod +x run_on_mainnet.sh if necessery)

This command will build the capricoin-core docker image -if not exists yet- then run the capricoin-core.

## Parameters:

-v (default:1.2.0.0)

-build build the image even if it already exists

### Capricoind parameters
Or you can pass parameter to capricoind like:

>--rescan


example:

> ./run_on_mainnet.sh -v 1.2.0.0 -build


## Example RPC usage

> curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:22713



## Example CLI usage
#### Outside docker:

> docker exec capricoin-node Capricoind getbalance 


## Inside docker:

> Capricoind getinfo

## Notes

RPC port: 22713


Note: Capricoin currenty don't have a working tesnet blocchain.
