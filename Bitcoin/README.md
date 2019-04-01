<h1>Usage</h1>

<h2>Testnet:</h2>

>./run_on_testnet.sh

This command will build the bitcoin-core docker image-if not exists yet- then run the bitcoin-core on testnet.

<h3>Parameters:</h3>

-v (default:0.17.1)

-build build the image even if it already exists

<h3>Bitcoind parameters</h3>
Or you can pass parameter to bitcoind like:

>--rescan

>--rpcauth='cointaner:d941010ee4d66ccf4ad96d757fa4773d$17f5c4a49dd3097c03049223cd9f2d493271cfa2e1e44ac6e1f72d39fbf75abf'

    (if no rpcauth is set the script will try to use user/password from bitcoin.conf)

    (if no bitcoin.conf is found the script will create one with the below user/pass -testnet only)

example:

> ./run_on_testnet.sh -v 0.17.0 -build

<h3>Notes</h3>

Test RPC port: 18332

RPC Username: cointaner

RPC Password: bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=

To withdraw some test coins to your account, you can use the following site:
https://coinfaucet.eu/en/btc-testnet/


<h3>Example RPC usage</h3>
>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:18332

<h3>Example CLI usage</h3>
<h4>Outside docker:</h4>

>docker exec -it bitcoin-core-testnet bitcoin-cli -testnet getmininginfo


<h4>Inside docker:</h4>

>bitcoin-cli -testnet getmininginfo


Note: 

    CLI uses cookie based authenticaion, so doesn't require username/password, but it only works localy.

<h2>Live bitcoin blockchain:</h2>

<Method 1>

Generate RPCAuth by:
>curl -sSL https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py python - \<username>



>./run_on_mainnet.sh --rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc'


<Method 2>
Create a bitcoin.conf (like bitcoin.conf.example)

>./run_on_mainnet.sh



This command will build the bitcoin-core docker image -if not exists yet- then run the bitcoin-core.

<h3>Parameters:</h3>

-v (default:0.17.1)

-build build the image even if it already exists

<h3>Bitcoind parameters</h3>
Or you can pass parameter to bitcoind like:

>--rescan

>--rpcauth='cointaner:d941010ee4d66ccf4ad96d757fa4773d$17f5c4a49dd3097c03049223cd9f2d493271cfa2e1e44ac6e1f72d39fbf75abf'
example:

> ./run_on_mainnet.sh -v 0.17.0 -build --rescan

<h3>Example RPC usage</h3>
>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://cointaner:bD0tf5Gm6ohGPAurmkm2ODph0vYAMjbnSBbcBf0ClpM=@127.0.0.1:8332

<h3>Example CLI usage</h3>
<h4>Outside docker:</h4>

>docker exec -it bitcoin-core-testnet bitcoin-cli getmininginfo


<h4>Inside docker:</h4>

>bitcoin-cli getmininginfo

<h3>Notes</h3>

RPC port: 8332


Note:  

    Testnet and mainnet use the same docker image.
    chmod +x run_on_...net.sh if necessery