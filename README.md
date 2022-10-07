# Balls of Art Workshop

This repository is for a Balls of Art workshop.

## Outline

* [What We Are Going to Create](#what-we-are-going-to-create)
  * [OpenSea NFT Collection Based on Workshop Code](#opensea-nft-collection-based-on-workshop-code)
  * [SVG Resources](#svg-resources)
* [Getting Started](#getting-started)
  * [Environment Variables for APIs](#environment-variables-for-apis)
* [Development](#development)
  * [Compile Contract](#compile-contract)
  * [Deploy to Local Blockchain](#deploy-to-local-blockchain)
  * [Deploy to Goerli](#deploy-to-goerli)
* [Next Steps](#next-steps)

## What We Are Going to Create

<p align="center">
  <img
    width="600"
    alt="Balls of Art"
    src="img/balls-of-art-thumb.png?raw=true"
  >
</p>

Balls of Art is an NFT collection that should serve as a basis to learn SVG-based, fully on-chain NFTs, and as a first step to start creating your own generative art NFTs. It shows in a clear, high-quality, yet simple way:

- How to structure an NFT project
- How to optimize for gas
- How to (pseudo) randomize
- How to draw simple SVGs
- How to start playing with SVG animation
- How to create a very simple generative art with all of the above

Elements that will be randomized:

<p align="center">
  <img
    width="600"
    alt="Balls of Art randomizations"
    src="img/balls-of-art-randomizations.png?raw=true"
  >
</p>

### OpenSea NFT Collection Based on Workshop Code

Visit https://testnets.opensea.io/collection/the-balls-of-art.

<p align="center">
  <img
    width="600"
    alt="Balls of Art on OpenSea"
    src="img/balls-of-art-opensea.png?raw=true"
  >
</p>

### SVG Resources

- Beginner tutorial:
[HTML SVG Graphics](https://www.w3schools.com/html/html5_svg.asp) at W3Schools
- Intermediate:
[SVG Tutorial](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial) at Mozilla Developer Network

## Getting Started

Clone the repository:

```shell
git clone https://github.com/velvet-shark/balls-of-art-tutorial.git balls-of-art-tutorial
```

Install dependencies:

```shell
cd balls-of-art-tutorial
yarn
```

### Environment Variables for APIs

Everything is ready for development, you just need to fill in the data in the `.env` file.

- At the very least you'll need:
  - `QUICKNODE_API_KEY_GOERLI` for connecting to the blockchain.
  - `PRIVATE_KEY` for deploying the contract to a testnet.
- `ETHERSCAN_API_KEY` is not strictly required, but since this example does not include a frontend UI for minting we will verify the contract and manually mint an NFT on Etherscan.

```shell
cp .env.example .env
```

- For QuickNode API, register for a free account at https://www.quicknode.com/ and select a Goerli Testnet endpoint.
- For Etherscan API, register at https://etherscan.io/register, then go to https://etherscan.io/myapikey and create a free API key.

## Development

### Compile Contract

Test if everything compiles properly:

```shell
yarn hardhat compile
```

### Deploy to Local Blockchain

Start a local blockchain node and deploy to `localhost`:

```shell
yarn hardhat node
yarn hardhat run scripts/deploy.js --network localhost
```

### Deploy to Goerli

To deploy to Goerli, uncomment the following code in `hardhat.config.js`:

```js
goerli: {
  chainId: 5,
  url: `${process.env.QUICKNODE_API_KEY_GOERLI}`,
  accounts: [`${process.env.PRIVATE_KEY}`]
}
```

Then run the `deploy.js` script with `goerli` passed to the `--network` flag:

```shell
yarn hardhat run scripts/deploy.js --network goerli
```

## Next Steps

This is only the first step, meant to show how to play with SVGs, add randomization, start creating on-chain NFTs. Things you can do next:

- Create a more complex art structure
- Take input from the user to create art with input as part of the equation (number of rows? different shapes? favorite color? emoji to insert into the NFT?)
- Learn more complex SVG
- Add more animation
- Create a front-end and an engaging minting page and process
- Create more art

Let me know what you have created. I'd love to see it! You can find me on Twitter [@velvet_shark](https://twitter.com/velvet_shark).
