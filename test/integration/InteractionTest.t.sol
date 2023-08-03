// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {FundFundMe,WithdrawFundMe} from "../../script/Interactions.s.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";


contract InteractionTest is Test {
    FundMe fundMe;

    // address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1; 
    address public constant USER = address(1);

    
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        console.log(address(deployFundMe), "deployFundMe script address");
        console.log(address(address(this)), "InteractionTest test address");
        console.log(msg.sender, "msg.sender");

        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    
    function testUserCanFundInteractions() public {
        FundFundMe fundFundme = new FundFundMe();
        fundFundme.fundFundMe(address(fundMe));


        address funder = fundMe.getFunder(0);


        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withDrawFundMe(address(fundMe));

        address withdrawAddress = address(withdrawFundMe);

        assertEq(funder, address(fundFundme));
        console.log(fundMe.getOwner(), "owner address");
        console.log(address(withdrawAddress),"Withdraw address");
        assertEq(msg.sender, fundMe.getOwner());
    }

}