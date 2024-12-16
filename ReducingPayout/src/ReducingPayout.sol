// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    uint256 public immutable depositedTime;

    constructor() payable {
        require(msg.value == 1 ether, "Contract must be initialized with 1 ether");
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        uint256 timePassed = block.timestamp - depositedTime;

        if (timePassed > 86400) {
            timePassed = 86400;
        }

        uint256 remainingPercentage = 1e18 - (timePassed * 1e18 / 86400);

        uint256 claimableAmount = (address(this).balance * remainingPercentage) / 1e18;

        require(claimableAmount > 0, "No ether left to withdraw");

        (bool success, ) = msg.sender.call{value: claimableAmount}("");
        require(success, "Transfer failed");
    }
}

