// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    error Bitch(bool result);

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
      (bool sent, ) = address(this).call{value: msg.value}("");

      if (!sent) {
        revert("Unable to remove!");
      }
    }

    /// @notice used to withdraw ether from the contract (No restriction on withdrawals)
    function removeEther(uint256 amount) external payable {
      (bool sent, ) = msg.sender.call{value: amount}("");

      if (!sent) {
        revert("Unable to remove!");
      }
    }

    receive() external payable {}
}
