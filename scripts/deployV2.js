const hre = require("hardhat");

async function main() {
  const ownersArr = ["0x90f79bf6eb2c4f870365e785982e1f101e93b906", "0x15d34aaf54267db7d7c367839aaf71a00a2c6a65"];
  const baseURI = "https://sharpart.vercel.app/nft-metadata/jsons/{id}.json"
  const addressArray = ownersArr.map(item => {
   return ethers.utils.getAddress(item)
  })
  const GameItem = await hre.ethers.getContractFactory("SharpDaoV2");
  const gameitem = await GameItem.deploy(
    addressArray,
    baseURI
  );

  await gameitem.deployed();

  console.log("Greeter deployed to:", gameitem.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
  