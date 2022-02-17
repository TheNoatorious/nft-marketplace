// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {
    uint MINTED_TOKEN = 1;

    // Array to store NFT's in
    string[] public kryptoBirdz;

    // check if token with the given ID already exists
    mapping(string => bool) _kryptoBirdzExists;

    // Initialize the contract to inherit name and symbol
    // from the ERC721Metadata contract
    // so that the name is KryptoBird and the symbol is KBIRDZ
    constructor() ERC721Connector('Kryptobird', 'KBIRDZ') {

    }

    function mint(string memory _kryptoBird) public {
        // Within the mapping: check if the kryptoBird of the current input, doesn't exist
        require(!_kryptoBirdzExists[_kryptoBird], 'error - KryptoBird already exists');

        // push each minted kryptobird into the kryptoBirdz array
        kryptoBirdz.push(_kryptoBird);

        // remove the minted token from the array
        uint _id = kryptoBirdz.length - MINTED_TOKEN;

        // the contract caller who mints gets a token with an ID
        _mint(msg.sender, _id);

        // get the given [KryptoBird] from the mapping and set its value to true
        _kryptoBirdzExists[_kryptoBird] = true;
    }
}