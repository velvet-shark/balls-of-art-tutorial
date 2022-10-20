const hre = require("hardhat");

async function main() {
  const BallsOfArt = await hre.ethers.getContractFactory("BallsOfArt");
  const ballsofart = await BallsOfArt.deploy();

  await ballsofart.deployed();

  console.log(`BallsOfArt deployed to ${ballsofart.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
