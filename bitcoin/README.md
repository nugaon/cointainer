<h1>Usage</h1>

<h2>Testnet:</h2>

>./run_on_testnet.sh

This command will build the bitcoin-core docker image-if not exists yet- then run the bitcoin-core on testnet.

<h3>Parameters:</h3>

--v (default:0.17.1)

--build build the image even if it already exists

example:

> ./run_on_testnet.sh --v 0.17.0 --build

<h3>Notes</h3>

Test RPC port: 18332

RPC Username: nemes

RPC Password: A0bluBX7fNIrr5utBEbFGe-mOuuNtsKCkYsOIZjCFnI=



<h3>Example RPC usage</h3>
>curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getmininginfo","params":[]}' http://nemes:A0bluBX7fNIrr5utBEbFGe-mOuuNtsKCkYsOIZjCFnI=@127.0.0.1:18332


<h2>Live bitcoin blockchain:</h2>

Generate RPCAuth by:
>curl -sSL https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py python - \<username>

Copy result to the run_on_mainnet.sh (overrideing rpcauth). (e.g.:

-rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc')

>./run_on_mainnet.sh


This command will build the bitcoin-core docker image -if not exists yet- then run the bitcoin-core.

<h3>Parameters:</h3>

--v (default:0.17.1)

--build build the image even if it already exists

example:

> ./run_on_mainnet.sh --v 0.17.0 --build

<h3>Notes</h3>

RPC port: 8332


Note: Testnet and mainnet use the same docker image.