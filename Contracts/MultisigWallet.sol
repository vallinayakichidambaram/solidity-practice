// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultisigWallet {

    // Events
    event deposit (address from, uint256 value, uint256 balance);
    event submitTransactionEvent (uint256 txnId,address from, address to, uint256 value, bytes data);

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public confirmations;

    // Structure of a transaction
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 numConfirmations;
    }

    // Array of transaction
    Transaction[] public transactions;

    // To save confirmations for a transaction
    mapping(uint256 => mapping (address => bool)) public isConfirmed;

    receive() external payable { 
        emit deposit(msg.sender, msg.value, address(this).balance);
    }

    // Modifiers
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not Owner");
        _;
    }

    //Initialise the owners and the confirmations required to execute a transaction
    constructor(address[] memory _owners, uint256 _confirmations) {
        require(_owners.length > 0, "Owners required");
        require(_confirmations > 0, "Number of confimations required");
        for(uint256 i=0;i<_owners.length;i++) {
            address owner = _owners[i];
            require(owner != address(0), "Not a valid owner");
            require(!isOwner[owner], "Not a valid owner");
            isOwner[owner] = true;
            owners.push(owner);
        }
        confirmations = _confirmations;
    }

    // Submit a transaction - Only owner can do it
    function submitTransaction(address _to, uint256 _value, bytes memory _data) public payable onlyOwner{
        uint256 txId = transactions.length;

        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false,
            numConfirmations: 0
        })
        );
    emit submitTransactionEvent(txId, msg.sender, _to, _value, _data);
    }
    
}