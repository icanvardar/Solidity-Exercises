// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    struct BetInfo {
      uint256 highestAmount;
      address bettor;
      uint256 endTime;
    }

    BetInfo public betInfo;

    function bet() public payable {
      (bool sent, ) = address(this).call{value: msg.value}("");

      if (!sent) {
        revert("Unable to send ether!");
      }

      if (msg.value > betInfo.highestAmount) {
        betInfo.highestAmount = msg.value;
        betInfo.bettor = msg.sender;
        betInfo.endTime = block.timestamp + 1 hours;
      }
    }

    function claimPrize() public {
      if (betInfo.endTime <= block.timestamp && betInfo.bettor == msg.sender) {
        (bool sent,) = msg.sender.call{value: address(this).balance}("");

        if (!sent) {
          revert("Unable to send ether!");
        }
      } else {
        revert("Unable to claim prize!");
      }
    }

    receive() external payable {}
}
