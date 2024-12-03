// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FilterOddNumbers {
    /*
        This exercise assumes you understand how to manipulate Array.
        1. Function `filterOdd` takes an array of uint256 as argument. 
        2. Filter and return an array with the odd numbers removed.
        Note: this is tricky because you cannot allocate a dynamic array in memory, 
              you need to count the even numbers then declare an array of that size.
    */

    function filterOdd(uint256[] memory _arr)
        public
        view
        returns (uint256[] memory)
    {
      uint256 evenNumCount = 0;
      uint256 i = 0;
      for (i; i < _arr.length; ++i) {
        if (_arr[i] % 2 == 0) {
          evenNumCount += 1;
        }
      }

      uint256[] memory result = new uint256[](evenNumCount);
      i = 0;
      uint256 j = 0;
      for (i; i < _arr.length; ++i) {
        if (_arr[i] % 2 == 0) {
          result[j] = _arr[i];
          j++;
        }
      }

      return result;
    }
}
