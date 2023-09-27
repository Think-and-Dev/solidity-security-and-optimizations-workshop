//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;
import "@openzeppelin/contracts/math/SafeMath.sol";

/**
 * Overflows playground
 */
contract Overflow07 {
    using SafeMath for uint256;
    uint256 public number;
    uint256 MAX_INT = 2 ** 256 - 1;

    /**
     * Causes an overflow but it won't fail on Solidity < 0.8
     */
    function overflow() public {
        number = MAX_INT + 2;
    }

    /**
     * This version will be safe even on Solidity < 0.8, by using the safe math library
     */
    function safeOverflow() public {
        number = MAX_INT.add(2);
    }
}
