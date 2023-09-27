//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title ReentrancyWithOZ
 * @dev This contract implements a secure version of a reentrancy attack vulnerable contract using the OpenZeppelin ReentrancyGuard library.
 * It allows users to deposit and withdraw funds, while preventing reentrancy attacks.
 */
contract ReentrancyWithOZ is ReentrancyGuard {
    //Balance tracking
    mapping(address => uint256) public balances;

    //Declare events
    event Deposit(address indexed _from, uint256 _value);
    event Withdraw(address indexed _from, uint256 _value);

    /**
     * @dev Allows the caller to check their balance.
     * @param _address The address to check the balance of.
     * @return The balance of the specified address.
     */
    function getBalance(
        address _address
    ) public view returns (uint256 balance) {
        balance = balances[_address];
    }

    /**
     * @dev Allows the caller to deposit funds into the contract.
     */
    function payIn() public payable {
        emit Deposit(msg.sender, msg.value);
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev Allows the caller to withdraw their available balance from the contract.
     * @notice This function is protected against reentrancy attacks.
     */
    function withdraw() public payable nonReentrant {
        require(balances[msg.sender] > 0, "Insufficiant balance");
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
