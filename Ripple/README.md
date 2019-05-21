# Description
The development documentation available on the [Ripple Developers](https://developers.ripple.com) website along with its [RPC API Documentation](https://developers.ripple.com/rippled-api.html).

## Requirements
You can read about the blockchain node requrements [here](https://developers.ripple.com/system-requirements.html)

## Exposed Ports
- 80 # http port which not configured by default
- 443 # https port which not configured by default
- 5005 # default local admin rpc connection
- 6006 # default local admin websocket connection
- 51235 # blockchain node communication port

## Mount points
```
│
├── /home/cointainer
│   ├── ripple # contains the output of the rippled server
│   │   ├── database # All database data. (This includes an SQLite database with configuration data)
│   │   │   ├── node_db # ledger database.
│   │   ├── logfile # logging information from rippled
│   ├── .config
│   │   ├── ripple # cointains configuration files for rippled server.
```

* 
The image automatically creates a volume from the /home/cointainer/ripple folder for synced blockchain data 

You can set your own configuration for rippled in the ./config folder.
*

# Testnet
Possible to try out the functionalities of the websocket or rpc APIs to connect endpoints of Ripple's free hosted testserver. 

Generate credentials for you on the Ripple's [XRP Test Net Faucet](https://developers.ripple.com/xrp-test-net-faucet.html) website.
