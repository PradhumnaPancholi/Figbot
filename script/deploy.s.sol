// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Figbot.sol";

contract DeployScript is Script {

	function run() external {
		vm.startBroadcast();
		Figbot figbot = new Figbot();
		vm.stopBroadcast();
	}	

}
