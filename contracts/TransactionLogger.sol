// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TransactionLogger {
    struct Transaction {
        address sender;
        string txId;
        uint256 amount;
        uint256 timestamp;
    }

    Transaction[] public transactions;

    event TransactionCommitted(address indexed sender, string txId, uint256 amount, uint256 timestamp);

    function commitTransaction(string memory _txId, uint256 _amount) public {
        Transaction memory newTx = Transaction({
            sender: msg.sender,
            txId: _txId,
            amount: _amount,
            timestamp: block.timestamp
        });

        transactions.push(newTx);

        emit TransactionCommitted(msg.sender, _txId, _amount, block.timestamp);
    }

    function getAllTransactions() public view returns (Transaction[] memory) {
        return transactions;
    }

    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }
}
