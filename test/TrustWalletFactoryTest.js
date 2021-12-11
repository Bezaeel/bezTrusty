const web3 = require("web3");
const _deploy_contracts = require("../migrations/2_deploy_contracts");

const TrustWalletFactory = artifacts.require("./TrustWalletFactory.sol");
const TalabiToken = artifacts.require("./TalabiToken.sol");

let amountToSend = web3.utils.toWei("1", "ether");
let trustWalletFactory;
let creator;
let owner;

contract("TrustWalletFactory", (accts) => {
    before(async () => {
        creator = accts[0];
        owner = accts[1];
        trustWalletFactory = await TrustWalletFactory.new({from: creator});
    });


    it("should create wallet", async () => {
        let now = Math.floor((new Date).getTime() / 1000);
        await trustWalletFactory.newWallet(owner, now, {from: creator, value: amountToSend});

        let creatorWallet = await trustWalletFactory.getWallets.call(creator);
        assert(1 == creatorWallet.length);
    })
})
