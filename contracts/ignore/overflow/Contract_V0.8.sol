//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * Overflows playground
 */
contract Overflow08 {
    uint8 public number;
    uint8 MAX_INT = 2 ** 8 - 1;

    /**
     * Causes an overflow, which should revert on Solidity >= 0.8
     */
    function overflow() public {
        number = MAX_INT + 2;
    }

    /**
     * Causes an overflow, but this won't fail on Solidity >= 0.8, keeping the same behaviour than it had on previous versions
     */
    function legacyOverflow() public {
        unchecked {
            number = MAX_INT + 2;
        }
    }
}
