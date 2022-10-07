# Balls of Art Workshop

This repository is for a Balls of Art workshop.

## What we're going to create

![Balls of Art](img/balls-of-art-thumb.png?raw=true "Balls of Art")

Balls of Art is an NFT collection that should serve as a basis to learn SVG-based, fully on-chain NFTs, and as a first step to start creating your own generative art NFTs. It shows in a clear, high-quality, yet simple way:

- How to structure an NFT project
- How to optimize for gas
- How (pseudo) randomness works and how to create it without using oracles
- How to draw simple SVGs
- How to start playing with SVG animation
- How to create a very simple generative art with all of the above.

Elements that will be randomized:

![Balls of Art](img/balls-of-art-randomizations.png?raw=true "Balls of Art randomizations")

## OpenSea NFT collection based on the code from this workshop

https://testnets.opensea.io/collection/the-balls-of-art

![Balls of Art](img/balls-of-art-opensea.png?raw=true "Balls of Art on OpenSea")

## APIs

Everything is ready for development, you just need to fill the data in the .env file. At the very least, `QUICKNODE_API_KEY_GOERLI` for connecting to blockchain and `PRIVATE_KEY` for being able to deploy the contract to a testnet.

Preferably, also `ETHERSCAN_API_KEY`.

For QuickNode API, register for a free account at https://www.quicknode.com/ and select a Goerli Testnet endpoint.

For Etherscan API, register at https://etherscan.io/register, then go to https://etherscan.io/myapikey and create a free API key.

## Getting Started

Clone the repository

```shell
git clone https://github.com/velvet-shark/balls-of-art-tutorial.git balls-of-art-tutorial
```

Install

```shell
cd balls-of-art-tutorial
```

```shell
yarn
```

## Development

Test if everything compiles properly

```shell
yarn hardhat compile
```

Deploy a local blockchain

```shell
yarn hardhat node
```

When developing locally, deploy to localhost

```shell
yarn hardhat run scripts/deploy.js --network localhost
```
