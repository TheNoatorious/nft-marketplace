// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    /*
    Building out the minting function:
        a. NFT to point to an address
        b. Keep track of the token ID's
        c. Keep track of the token owner addresses to token ids
        d. Keep track of how many tokens an owner address has
        e. Create an event that emits: 
            Transfer log - contract address, where it is being minted to, the id
    */

contract ERC721 {
    uint constant NEW_TOKEN = 1;

    event Transfer(
        address from, 
        address to, uint256 
        tokenId
    );

    // Mapping in solidity creates a hash table of key pair values
    // Mapping from token id to the owner
    mapping(uint => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _ownedTokens;

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly 
    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner != address(0), 'Owner query for non-existent token');

        // return the token count of the _owner input
        return _ownedTokens[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'Query for non-existent owner');

        return owner;
    }

    function _exists(uint256 tokenId) internal view returns(bool) {
        // setting the address of token owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return if address is not zero
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        // require that the address isn't zero
        require(to != address(0), 'ERC721: minting to the zero address');
        // require that the token does not already exists
        require(!_exists(tokenId), 'ERC721: token already minted');

        // adding a new address with a token id for minting
        _tokenOwner[tokenId] = to;

        // keeping track of each address that is minting and adding one to the account
        _ownedTokens[to] += NEW_TOKEN;

        emit Transfer(address(0), to, tokenId);
    }
}