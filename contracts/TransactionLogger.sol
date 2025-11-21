// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TransactionLogger {
    struct Transaction {
        uint256 userId;
        uint256 campaignId;
        uint256 transactionId;
        uint256 amount;
        string status;
        string note;
        uint256 timestamp;
    }

    Transaction[] public transactions;

    event TransactionCommitted(
        uint256 indexed userId,
        uint256 indexed campaignId,
        uint256 indexed transactionId,
        uint256 amount,
        string status,
        string note,
        uint256 timestamp
    );

    function commitTransaction(
        uint256 userId,
        uint256 campaignId,
        uint256 transactionId,
        uint256 amount,
        string memory status,
        string memory note
    ) public {
        Transaction memory newTx = Transaction({
            userId: userId,
            campaignId: campaignId,
            transactionId: transactionId,
            amount: amount,
            status: status,
            note: note,
            timestamp: block.timestamp
        });

        transactions.push(newTx);

        emit TransactionCommitted(
            userId,
            campaignId,
            transactionId,
            amount,
            status,
            note,
            block.timestamp
        );
    }

    function getTransactionByTxId(uint256 txId) public view returns (
        uint256 userId,
        uint256 campaignId,
        uint256 transactionId,
        uint256 amount,
        string memory status,
        string memory note,
        uint256 timestamp
    ) {
        for (uint i = 0; i < transactions.length; i++) {
            if (transactions[i].transactionId == txId) {
                Transaction memory t = transactions[i];
                return (t.userId, t.campaignId, t.transactionId, t.amount, t.status, t.note, t.timestamp);
            }
        }
        revert("tx not found");
    }

    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }
}
