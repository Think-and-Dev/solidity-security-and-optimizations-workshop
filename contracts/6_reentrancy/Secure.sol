//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title Secure
 * @dev A contract that allows users to deposit and withdraw funds securely.
 */
contract Secure {
    //Balance tracking
    mapping(address => uint256) public balances;

    //Declare events
    event Deposit(address indexed _from, uint256 _value);
    event Withdraw(address indexed _from, uint256 _value);

    /**
     * @dev Returns the balance of the specified address.
     * @param _address The address to query the balance of.
     * @return balance The balance of the specified address.
     */
    function getBalance(
        address _address
    ) public view returns (uint256 balance) {
        balance = balances[_address];
    }

    /**
     * @dev Allows the caller to add balance to their account.
     */
    function payIn() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @dev Withdraws the balance available to the caller.
     */
    function withdraw() public payable {
        require(balances[msg.sender] > 0, "Insufficient balance");
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Failed to send funds");
        emit Withdraw(msg.sender, balance);
    }

    /**
     * @dev Returns the balance of the contract.
     * @return The balance of the contract.
     */
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
