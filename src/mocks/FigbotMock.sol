// SPDX-License-Identifier : GPL-3.0 
pragma solidity 0.8.13;

import "../Figbot.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";

contract FigbotMock is Figbot {
		using Counters for Counters.Counter;
		
		//appraoch 1:  fast forward your state variable to the constraint you are testing for //
		// make sure to call this function in your test before the calling the function to test the constraint
	//	function setTokenIdToMaxSupply() public {
	//			for(uint256 i = 0; i <= MAX_SUPPLY; i++) {
	//					_tokenIds.increment();
	//			}
	//	}

		//approach 2: create a fake state variable, and override the "mint" function //
		uint256 fakeTokenIds = 100;
  	
		function mint() public override payable {
				require(msg.value >= COST, "Insufficient funds");
				require(MAX_SUPPLY > fakeTokenIds, "You can not mint anymore");
				//increment tokenId - started at 0//
				_tokenIds.increment();
				_safeMint(msg.sender, _tokenIds.current());
				_setTokenURI(_tokenIds.current(), TOKEN_URI);
		}
}
