// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TrustWallet {
    address public creator;
    address public owner;
    uint256 public unlockDate;
    uint256 public createdAt;

    constructor(address _creator, address _owner, uint256 _unlockDate) {
        creator = _creator;
        owner = _owner;
        unlockDate = _unlockDate;
        createdAt = block.timestamp;
    }

    modifier OnlyOwner {
        require(msg.sender == owner);
        _;
    }

    //withdraw
    function Withdraw() OnlyOwner public {
        require(block.timestamp >= createdAt);
        payable(msg.sender).transfer(address(this).balance);
    }

    //withdraw token
    function WithdrawToken(address _tokenContract) OnlyOwner public {
        require(block.timestamp >= unlockDate);
        ERC20 token = ERC20(_tokenContract);
        uint256 tokenBalance = token.balanceOf(address(this));
        token.transfer(owner, tokenBalance);


    }

    //info
    function Info() public view returns (address, address, uint256, uint256) {
        return (creator, owner, unlockDate, createdAt);
    }

    fallback() external {}
}