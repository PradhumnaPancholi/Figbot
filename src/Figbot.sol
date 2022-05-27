// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";

contract Figbot is ERC721URIStorage, Ownable{

    using Counters for Counters.Counter;
    Counters.Counter public _tokenIds;

    uint256 public constant MAX_SUPPLY = 100;
    uint256 public constant COST = 0.69 ether;
    string constant TOKEN_URI = "ipfs://QmWQLuGKWiho3cR8sEqZQGYfgEUAJrogyGkfC9ts2eQ4LF";
    constructor() ERC721("Figbot", "FBT") {}

    event Withdraw(address _to, uint256 _value);

    function mint() public virtual payable {
        require(msg.value >= COST, "Insufficient funds");
        require(MAX_SUPPLY > _tokenIds.current(), "You can not mint anymore");

        //increment tokenId - started at 0//
        _tokenIds.increment();
        _safeMint(msg.sender, _tokenIds.current());
        _setTokenURI(_tokenIds.current(), TOKEN_URI);
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ether left to withdraw");
        (bool success, ) = (msg.sender).call{value: balance}("");
        require(success, "Withdrawal Failed");
        emit Withdraw(msg.sender, balance);
    }

}
