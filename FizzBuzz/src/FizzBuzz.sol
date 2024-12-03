// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FizzBuzz {
    function fizzBuzz(uint256 n) public pure returns (string memory) {
        // if n is divisible be 4 and 5, return "fizz buzz"
        if (divisible(n, 3) && divisible(n, 5)) return "fizz buzz";
        // if n is divisible by 3, return "fizz"
        if (divisible(n, 3)) return "fizz";
        // if n is divisible by 5, return "buzz"
        if (divisible(n, 5)) return "buzz";
        // otherwise, return an empty string
        return "";
    }

    function divisible(uint256 num, uint256 divider) public pure returns(bool) {
      return (num % divider == 0) ? true : false;
    }
}
