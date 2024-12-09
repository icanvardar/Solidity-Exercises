// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IsSorted {
    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order) or false if its not.
     */
    function isSorted(uint256[] memory arr) public view returns (bool result) {
      assembly {
        result := true

        let i := 1
        for { } lt(i, mload(arr)) { i := add(i, 1) } {
          let prev := mload(add(arr, mul(i, 0x20)))
          let curr := mload(add(arr, mul(add(i, 1), 0x20)))

          if gt(prev, curr) {
            result := false
            break
          }
        }
      }
    }
}
