// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Figbot.sol";
contract ContractTest is Test {

    Figbot figbot;
    function setUp() public {
       figbot = new Figbot(); 
    }

    function testMaxSupply() public {
        assertEq(figbot.MAX_SUPPLY(), 100);
    }

    function testMint() public {
        
    }
    
    function testWithdraw() public {
        
    }
}
