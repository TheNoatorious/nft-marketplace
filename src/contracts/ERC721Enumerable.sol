// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {
    uint256[] private _allTokens;

    // mapping from tokenid to position in _alltokens
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from token id index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);

        // 2 things
        // a. add tokens to the owner
        // b. all tokens to our totalsupply - to alltokens

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    // Add tokens to the _allTokens array and set the position
    // of the tokens indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        // allTokensIndex, we add tokenID.
        // Where do you add it to that position?
        // To the length of allTokens
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. token id to the address in ownerTokens
        // 2. ownedTokensIndex tokenId set to the address of OwnedTokens position
        // 3. we want to execute the function with minting
        // 4. Compile and migrate

        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // 1 - function that returns the tokenbyIndex
    function tokenByIndex(uint256 index) public view returns(uint256) {
        require(index < totalSupply(), 'index is out of bounds');
        return _allTokens[index];
    }

    // 2 0 returns tokenbyownerindex
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns(uint256) {
        require(index < balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }

    // return the total supply of the _allTokens array
    function totalSupply() public view returns(uint256) {
        return _allTokens.length;
    }
}