// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import "./Callee.sol";

/**
 * Overflows playground
 */
contract Caller {
    /**
     * Calls the msgSender method on the provided Callee
     */
    function callMsgSender(
        address callee
    ) public view returns (address result) {
        result = Callee(callee).msgSender();
    }

    /**
     * Calls the txOrigin method on the provided Callee
     */
    function callTxOrigin(address callee) public view returns (address result) {
        result = Callee(callee).txOrigin();
    }
}
