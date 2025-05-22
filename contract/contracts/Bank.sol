// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vault.sol";

contract Bank is Vault {
    event Withdrawn(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(owner == msg.sender, "Only the owner can call withdraw.");
        _;
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(sentValue >= _amount, "Insufficient balance in Vault.");

        sentValue -= _amount;
        //Solidity의 트랜잭션 원자성 보장으로 require 이후 실패가
        //발생하면 그 이전 변경된 상태가 자동으로 롤백된다
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed.");
        emit Withdrawn(msg.sender, _amount);
    }
}
