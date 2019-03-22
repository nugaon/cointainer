# Cointainer

The Cointainer is a git repository for blockchain based local node Docker images. The images have the ability to connect both the Testnet and the Mainnet. With this you can easily build up local nodes for test or for production use cases.

## Project structure

```
│
├── local_nodes/ - contains all available blockchain node images.
│   ├── {CoinName} - the name of the coin, which has testnet and mainnet
│   │   ├── README.md - Describes the usage of the image, lists the helpful documentaries for the coin, etc.
│   │   ├── Dockerfile - if no official image available for the coin it's necessary to build the image :)
│   │   ├── run_on_testnet.sh - build (or pull) the image by Dockerfile, then starts within a container on testnet.
│   │   └── run_on_mainnet.sh - build (or pull) the image by Dockerfile, then starts within a container on mainnet.
```

## Docker images

The images must to be Linux kernel based.
