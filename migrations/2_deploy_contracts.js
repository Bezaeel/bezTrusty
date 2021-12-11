const TrustWalletFactory = artifacts.require("TrustWalletFactory");
const TalabiToken = artifacts.require("TalabiToken");

module.exports = function (deployer) {
  deployer.deploy(TrustWalletFactory);
  deployer.deploy(TalabiToken);
};
