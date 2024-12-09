// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Mean {
    /**
     * The goal of this exercise is to return the mean of the numbers in "arr"
     */
    function mean(uint256[] memory arr) public view returns (uint256 result) {
        assembly {
          if iszero(mload(arr)) {
            let ptr := mload(0x40)

            mstore(ptr, 0x4e487b7100000000000000000000000000000000000000000000000000000000)

            mstore(add(ptr, 4), 0x12)

            revert(ptr, 36)
          }

          let sum := 0

          if gt(mload(arr), 0) {
            let i := 0
            for {  } lt(i, mload(arr)) { i := add(1, i) } {
                sum := add(sum, mload(add(arr, mul(add(i, 1), 0x20)))) 
            }

            result := div(sum, mload(arr))
          }
        }
    }
}
