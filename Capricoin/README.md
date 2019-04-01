<h1>Usage</h1>

Create a Capricoin.conf file based on the Capricoin_example.conf 

>./run_on_mainnet.sh
(chmod +x run_on_mainnet.sh if necessery)

This command will build the capricoin-core docker image -if not exists yet- then run the capricoin-core.

<h3>Parameters:</h3>

-v (default:1.2.0.0)

-build build the image even if it already exists

<h3>Capricoind parameters</h3>
Or you can pass parameter to capricoind like:

>--rescan


example:

> ./run_on_mainnet.sh -v 1.2.0.0 -build


<h3>Example RPC usage</h3>

> curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:22713



<h3>Example CLI usage</h3>
<h4>Outside docker:</h4>

> docker exec capricoin-node Capricoind getbalance 


<h4>Inside docker:</h4>

> Capricoind getbalance
<h3>Notes</h3>

RPC port: 22713


Note: Capricoin currenty don't have a working tesnet blocchain.