// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
// fund


// this contract sends funds to the FundMe contract
contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 1 ether;

    function fundFundMe(address mostRecetlyDeployed) public {
        vm.deal(address(this),SEND_VALUE);
        FundMe(payable(mostRecetlyDeployed)).fund{value: SEND_VALUE}();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

    }
}

contract WithdrawFundMe is Script{

    function withDrawFundMe(address mostRecetlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecetlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withDrawFundMe(mostRecentlyDeployed);
    }
}