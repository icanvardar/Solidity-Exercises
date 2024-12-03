// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBankV2 {
    /// used to store the balance of users
    ///     USER    =>  BALANCE
    mapping(address => uint256) public balances;

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
      balances[msg.sender] += msg.value;

      (bool sent, ) = address(this).call{value: msg.value}(""); 

      if (!sent) {
        revert("Unable to add ether!"); 
      }
    }

    /// @notice used to withdraw ether from the contract
    /// @param amount of ether to remove. Cannot execeed balance i.e users cannot withdraw more than they deposited
    function removeEther(uint256 amount) external payable {
        if (balances[msg.sender] < amount) {
          revert("Insufficient balance");
        }

        balances[msg.sender] -= amount;

        (bool sent, ) = msg.sender.call{value: amount}(""); 

        if (!sent) {
          revert("Unable to add ether!"); 
        }
    }

    receive() payable external {}
}
