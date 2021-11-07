const hre = require("hardhat");
const NUM_ITEMS = 5;
const OWNER_ADDRESS = "0xdd079a5B0CDa6707960197a6B195a436E3CE7836";
const NFT_ADDRESS = "0x09E3049a06c3BF520CEcA77dd49EE3d80C2De4B3";

//todo - needs reworking for erc 1155
async function main() {

      const GameItem = await hre.ethers.getContractFactory("GameItem");
      const gameItem = await GameItem.attach(NFT_ADDRESS)

      for (var i = 1; i <= NUM_ITEMS; i++) {
            await gameItem.mintItem(OWNER_ADDRESS, `your_metadata_uri`);
      }
}

main()
      .then(() => process.exit(0))
      .catch((error) => {
            console.error(error);
            process.exit(1);
      });
