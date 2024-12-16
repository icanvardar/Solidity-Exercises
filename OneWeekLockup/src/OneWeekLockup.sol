// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    struct UserInfo {
      uint256 balance;
      uint256 lastDeposit;
    }

    mapping(address => UserInfo) public userInfo;

    function balanceOf(address user) public view returns (uint256) {
      return userInfo[user].balance;
    }

    function depositEther() external payable {
      userInfo[msg.sender].balance = msg.value;
      userInfo[msg.sender].lastDeposit = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
      UserInfo memory info = userInfo[msg.sender];

      if (info.balance < amount) {
        revert("cannot withdraw");
      }

      if ((block.timestamp - info.lastDeposit) < 604800) {
        revert("you have to wait a week before withdraw");
      }

      userInfo[msg.sender].balance -= amount;

      (bool sent, ) = msg.sender.call{ value: amount }("");

      if (!sent) {
        revert("unable to send ether");
      }
    }

    receive() external payable {}
}
