// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IsPrime {
    /**
     * The goal of this exercise is to return if "num" is prime or not (true or false)
     */
    function isPrime(uint256 num) public view returns (bool result) {
      assembly {
        result := 0x01 

        if lt(num, 2) {
          result := 0x00
        }

        let half := add(div(num, 2), 1)
        if eq(gt(num, 1), 1) {
          for { let i := 2 } lt(i, half) { i := add(i, 1) } {
            if iszero(mod(num, i)) {
              result := 0
              break
            }
          }
        }
      }
    }
}
