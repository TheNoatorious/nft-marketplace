// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract Kryptobird is ERC721Connector {

    // Initialize the contract to inherit name and symbol
    // from the ERC721Metadata contract
    // so that the name is KryptoBird and the symbol is KBIRDZ
    constructor() ERC721Connector('Kryptobird', 'KBIRDZ') {

    }
}