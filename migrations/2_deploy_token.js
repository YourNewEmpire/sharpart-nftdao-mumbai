const nft = artifacts.require("GameItems");

module.exports = async function (deployer) {
 await deployer.deploy(nft);
};
