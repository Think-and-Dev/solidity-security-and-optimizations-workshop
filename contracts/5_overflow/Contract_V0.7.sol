//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

/**
 * Overflows playground
 */
contract Overflow07 {
    uint8 public number;
    uint8 MAX_INT = 2 ** 8 - 1;

    /**
     * Causes an overflow but it won't fail on Solidity < 0.8
     */
    function overflow() public {
        number = MAX_INT + 2;
    }
}
