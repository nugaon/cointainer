# Description
Combining the digital crypto currency phenomenon with environmentally friendly activity.
Greenshilling is committed to supporting environmentally friendly activity to sustain our planet by making a contribution from every transaction.
Greenshilling has the potential to strengthen against other currencies, whether they be traditional Fiat currency or other electronic currencies, and it can be used for a wide range of purposes including as a payment method on developing ecommerce shopping platform and also through a developing gaming portal. Greeenshilling (GSL) is a Proof of work(PoW) and Proof of Stake(PoS) Cryptocurrency using the SHA256d algorithm.
Fore more information visit the [official page](https://www.greenshilling.com/)

Green Shilling is a fork from bitcoin core, therefore, you can use the documentation of bitcoin:

The development documentation available on the [Bitcoin Developer Documentation](https://bitcoin.org/en/developer-documentation) website along with its [RPC API Documentation](https://bitcoincore.org/en/doc/).

The image builds and runs the [GreenShillingd daemon](https://github.com/greenshilling/greenshilling)

Search for transactions block on its [own explorer](https://www.greenshilling.net/chain/Greenshilling)

## Exposed Port
- 9945 # GreenShilling communication/discovery port
- 9946 # Mainnet JSON-RPC/REST port

## Mount points
```
│
└── /home/cointainer
    └── .GSL # contains the files of GreenShillingd
        ├── debug.log # daemon log file.
        ├── wallet.dat # wallet key file, contains your wallet private key
        ├── blk[X].dat # Contains block data
        └── __db.[X] # Contains blockchain database data
```

# Usage

Set RPC user and password in * config/GreenShilling.conf *
The rpcallowip config attribute doesn't work in here, so run the container with --network host param.

>./run_on_mainnet.sh

## Example CLI usage

Outside docker:

Get balance of the wallet:
> docker exec greenshilling-mainnet GreenShillingd getbalance

Get info about the network and wallet:
> docker exec greenshilling-mainnet GreenShillingd getinfo

Create new address in the wallet:
> docker exec greenshilling-mainnet GreenShillingd getaccountaddress main-deposit-account

Get account addresses:
>  docker exec greenshilling-mainnet GreenShillingd getaddressesbyaccount main-deposit-account

Inside docker:

Get balance of the wallet:
> GreenShillingd getinfo


Green Shilling currenty don't have a working tesnet blockchain.
