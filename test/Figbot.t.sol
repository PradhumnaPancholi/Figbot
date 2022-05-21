// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "../src/Figbot.sol";


contract ContractTest is Test {

    Figbot figbot;
    address owner = address(0x1223);
    function setUp() public {
        vm.startPrank(owner);
        figbot = new Figbot();
        vm.stopPrank(); 
    }

    function testMaxSupply() public {
        assertEq(figbot.MAX_SUPPLY(), 100);
    }

    function testMint() public {
        // swtich address/account and give it some balance //
        address alice = address(0x1889);
        hoax(alice, 1 ether);
        figbot.mint{value: 0.8 ether}();
        assertEq(figbot.balanceOf(alice), 1);
    }
    
    function testWithdrawFromOwner() public {
        // switch to a diffent acount and mint a nft to have funds in contrat//
        address bob = address(0x1778);
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
