# Description
Capricoin core is a fork from bitcoin core, therefore, you can use the documentatoin of bitcoin:


The development documentation available on the [Ripple Developers](https://developers.ripple.com) website along with its [RPC API Documentation](https://developers.ripple.com/rippled-api.html).


For more information visit [Capricoin github repository])(https://github.com/Capricoinofficial/Capricoin)

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


### Example:


> ./run_on_mainnet.sh -v 1.2.0.0 -build


## Example RPC usage

> curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://foo:SUPERSECRETPASSWORD@127.0.0.1:22713



## Example CLI usage
#### Outside docker:

> docker exec capricoin-node Capricoind getbalance 


## Inside docker:

> Capricoind getinfo

    RPC port: 22713
    Capricoin currenty don't have a working tesnet blocchain.
