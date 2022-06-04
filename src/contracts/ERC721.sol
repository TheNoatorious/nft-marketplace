// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';

    /*
    Building out the minting function:
        a. NFT to point to an address
        b. Keep track of the token ID's
        c. Keep track of the token owner addresses to token ids
        d. Keep track of how many tokens an owner address has
        e. Create an event that emits:
            Transfer log - contract address, where it is being minted to, the id
    */

contract ERC721 is ERC165, IERC721 {
    uint constant NEW_TOKEN = 1;

    // Mapping in solidity creates a hash table of key pair values
    // Mapping from token id to the owner
    mapping(uint => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _ownedTokens;

    // Mapping token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly
    function balanceOf(address _owner) public override view returns(uint256) {
        require(_owner != address(0), 'Owner query for non-existent token');

        // return the token count of the _owner input
        return _ownedTokens[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public override view returns(address) {
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

    /// @notice Transfer ownership of an NFT
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'Address can not be 0');
        require(ownerOf(_tokenId) == _from, 'Address does not own the token');

        // 1. add the token id to the address receiving the token
        // 2. update the balance of the address from token
        // 3. update the balance of the address too
        // 4. add the safe functionality:
        //      a. require that the address receiving a token is not a zero address
        //      b. require the address transfering the token actually owns the token

        _ownedTokens[_from] -= NEW_TOKEN;
        _ownedTokens[_to] += NEW_TOKEN;

        //transfer - set owner to the new address
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public override {
        require(isApprovedOrOwner(msg.sender, _tokenId), 'Error: Transfer is not approved');
        _transferFrom(_from, _to, _tokenId);
    }

    // 1. require that he person approving is the owner
    // 2. approve an address to a token (tokenId)
    // 3. require that we cant approve sending tokens
    // 4. update the map of the approval addresses
    function approve(address _to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, 'Error: approval to current owner');
        require(msg.sender == owner, 'Error: Current caller is not the owner');

        _tokenApprovals[tokenId] = _to;

        emit Approval(owner, _to, tokenId);
    }

    //TODO: download oppenzeppelin library to write out the approval function
    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool) {
        require(_exists(tokenId), 'Error: Token Does not exist');

        address owner = ownerOf(tokenId);
        return(spender == owner);
    }
}