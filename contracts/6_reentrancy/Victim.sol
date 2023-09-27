//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title Victim
 * @dev A contract that allows users to deposit and withdraw funds.
 * It also keeps track of user balances and emits events for deposits and withdrawals.
 * This contract is vulnerable to reentrancy attacks.
 */
contract Victim {
    //Balance tracking
    mapping(address => uint256) public balances;

    //Declare events
    event Deposit(address indexed _from, uint256 _value);
    event Withdraw(address indexed _from, uint256 _value);

    /**
     * @dev Returns the balance of a given address.
     * @param _address The address to check the balance of.
     * @return balance The balance of the given address.
     */
    function getBalance(
        address _address
    ) public view returns (uint256 balance) {
        balance = balances[_address];
    }

    /**
     * @dev Allows a user to deposit funds into the contract.
     */
    function payIn() public payable {
        emit Deposit(msg.sender, msg.value);
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev Allows a user to withdraw their available balance from the contract.
     * Emits a Withdraw event upon successful withdrawal.
     * This function is vulnerable to reentrancy attacks.
     * @notice Throws an error if the user has insufficient balance.
     */
    function withdraw() public payable {
        require(balances[msg.sender] > 0, "Insufficient balance");
        emit Withdraw(msg.sender, balances[msg.sender]);
        (bool success, ) = payable(msg.sender).call{
            value: balances[msg.sender]
        }("");
        require(success, "Failed to send funds");
        balances[msg.sender] = 0;
    }

    /**
     * @dev Returns the balance of the contract.
     * @return The balance of the contract.
     */
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
