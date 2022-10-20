require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config({ path: ".env" });

const defaultNetwork = "localhost";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      metadata: {
        // Not including the metadata hash
        // https://github.com/paulrberg/solidity-template/issues/31
        bytecodeHash: "none"
      },
      optimizer: {
        enabled: true,
        runs: 200
      },
      viaIR: true
    }
  },

  defaultNetwork,

  networks: {
    localhost: {
      chainId: 31337
    }

    /////////
    // L1 NETWORKS
    /////////

    // mainnet: {
    //   chainId: 1,
    //   url: `{process.env.QUICKNODE_API_KEY_MAINNET}`,
    //   accounts: [`${process.env.PRIVATE_KEY}`],
    // },

    // L1 TEST NETWORKS

    // goerli: {
    //   chainId: 5,
    //   url: `${process.env.QUICKNODE_API_KEY_GOERLI}`,
    //   accounts: [`${process.env.PRIVATE_KEY}`]
    // }

    /////////
    // L2 NETWORKS
    /////////

    // polygon: {
    //   chainId: 137,
    //   url: `{process.env.QUICKNODE_API_KEY_GOERLI_POLYGON}`,
    //   accounts: [`${process.env.PRIVATE_KEY}`],
    // },

    // L2 TEST NETWORKS

    // mumbai: {
    //   chainId: 80001,
    //   url: `${process.env.QUICKNODE_API_KEY_MUMBAI}`,
    //   accounts: [`${process.env.PRIVATE_KEY}`],
    // },
  },
  namedAccounts: {
    deployer: {
      default: 0 // here this will by default take the first account as deployer
    },
    tokenOwner: 1,
    etherscan: {
      apiKey: process.env.ETHERSCAN_API_KEY
    }
  },
  etherscan: {
    apiKey: {
      goerli: process.env.ETHERSCAN_API_KEY
    }
  }
};
