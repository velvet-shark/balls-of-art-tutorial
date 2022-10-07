# Balls of Art Workshop

This repository is for a Balls of Art workshop.

## What we're going to create

![Balls of Art](img/balls-of-art-thumb.png?raw=true "Balls of Art")

Balls of Art is an NFT collection that should serve as a basis to learn SVG-based, fully on-chain NFTs, and as a first step to start creating your own generative art NFTs. It shows in a clear, high-quality, yet simple way:

- How to structure an NFT project
- How to optimize for gas
- How to (pseudo) randomize
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

## SVG resources

Beginner tutorial:
[HTML SVG Graphics](https://www.w3schools.com/html/html5_svg.asp) at W3Schools

Intermediate:
[SVG Tutorial](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial) at Mozilla Developer Network

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

## Next steps

This is only the first step, meant to show how to play with SVGs, add randomization, start creating on-chain NFTs.

Things you can do next:

- Create a more complex art structure
- Take input from the user to create art with input as part of the equation (number of rows? different shapes? favorite color? emoji to insert into the NFT?)
- Learn more complex SVG
- Add more animation
- Create a front-end and an engaging minting page and process
- Create more art

Let me know what you have created. I'd love to see it!

You can find me on Twitter [@velvet_shark](https://twitter.com/velvet_shark)
