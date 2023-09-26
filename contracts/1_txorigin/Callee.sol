// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

/**
 * Overflows playground
 */
contract Callee {
    /**
     * Returns the msg.sender
     */
    function msgSender() public view returns (address) {
        return msg.sender;
    }

    /**
     * Returns the tx.origin
     */
    function txOrigin() public view returns (address) {
        return tx.origin;
    }
}
