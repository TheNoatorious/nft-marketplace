# nft-marketplace-starter-kit
Make sure you are in the source file and run `npm install` on the terminal to download the appropriate packages already defined to the package.json file. 

**Ensure you have downloaded the following additionally **

1. Ganache
2. Truffle (global installation)
3. Metamask (hooked up on the browser)

**To run the development server on a local host scripts:** 
`npm run start`

## Truffle framework for smart contracts

To compile contracts:
`truffle compile`
This compiles the contract to bytecode (low-level language).

To migrate (deploy) contracts to a new address:
`truffle migrate --reset`
The contract will be saved to Ganache.

## Testing a contract

1. To test a contract, launch Truffle console:
`truffle console`

2. Deploy the contract first by creating a variable:
`kryptoBird = await Kryptobird.deployed()` the result will be undefined.

3. Write a function to call, e.g.:
`kryptoBird.getName()` returns the name.




