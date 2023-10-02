//SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
// Import SafeMath library from OpenZeppelin. This is forced to Solidity 0.6.x compatible version using github import.
// This import is not supported by hardhat, but it is supported by Remix.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/math/SafeMath.sol";

/**
 * Overflows playground
 */
contract OverflowLessThan08 {
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
