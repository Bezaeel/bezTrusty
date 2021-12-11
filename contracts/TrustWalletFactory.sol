// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./TrustWallet.sol";

contract TrustWalletFactory {
    mapping (address=>address[]) wallets;

    function getWallet(address user) public view returns(address[] memory){
        return wallets[user];
    }

    function newWallet(address owner, uint256 unlockDate) public payable returns(address wallet){
        wallet = address(new TrustWallet(msg.sender, owner, unlockDate));
        wallets[msg.sender].push(wallet);

        if(msg.sender != owner){
            wallets[owner].push(wallet);
        }
        payable(wallet).transfer(msg.value);
        emit Created(wallet, msg.sender, owner, block.timestamp, unlockDate, msg.value);
    }

    fallback() external {
        revert();
    }

    event Created(address wallet, address from, address to, uint256 createdAt, uint256 unlockDate, uint256 amount);
}