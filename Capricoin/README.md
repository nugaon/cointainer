<h1>Usage</h1>

Create a Capricoin.conf file based on the Capricoin_example.conf

>./run_on_mainnet.sh
(chmod +x run_on_mainnet.sh if necessery)

This command will build the capricoin-core docker image -if not exists yet- then run the capricoin-core.

<h3>Parameters:</h3>

--v (default:1.2.0.0)

--build build the image even if it already exists

example:

> ./run_on_mainnet.sh --v 1.2.0.0 --build

<h3>Notes</h3>

RPC port: 22713


Note: Capricoin currenty don't have a working tesnet blocchain.