// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Figbot.sol";


contract FigbotTest is Test {

    Figbot figbot;
    address owner = address(0x1223);
    address alice = address(0x1889);
    address bob = address(0x1778);
    function setUp() public {
        vm.startPrank(owner);
        figbot = new Figbot();
        vm.stopPrank(); 
    }

    function testMaxSupply() public {
        assertEq(figbot.MAX_SUPPLY(), 100);
    }

    // test for a succesfull mint // 
    function testMint() public {
        // swtich address/account and give it some balance //
        vm.startPrank(alice);
        vm.deal(alice, 1 ether);
        figbot.mint{value: 0.69 ether}();
        vm.stopPrank();
        assertEq(figbot.balanceOf(alice), 1);
    }


    //test for unsuccesfull mint due to insuffucient funds//
    function testFailMint() public {
        vm.startPrank(bob);
        vm.deal(bob, 0.5 ether);
        figbot.mint{value: 0.69 ether};
        vm.stopPrank();
        assertEq(figbot.balanceOf(bob), 1);
    }
    
    function testWithdrawFromOwner() public {
        // switch to a diffent acount and mint a nft to have funds in contrat//
        vm.startPrank(bob);
        vm.deal(bob, 1 ether);
        figbot.mint{value: 0.69 ether}();
        assertEq(figbot.balanceOf(bob), 1);
        vm.stopPrank();
        //call withdraw with owner address//
        vm.startPrank(owner);
        figbot.withdrawFunds();
        assertEq(owner.balance, 0.69  ether);
    }

}
