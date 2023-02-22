# ERC20-Diamond-Proxy
This is the sample implementation of ERC20 using diamond proxy repository [SolidState](https://github.com/solidstate-network/solidstate-solidity) and [Hardhat](https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-toolbox) unit testing for diamond proxy

----------------------------------------------------------------
# HOW TO USAGE

- clone the repository
- run command 
```
$ npm i
```

it will install all dependencies from 
- [Hardhat](https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-toolbox) : To unit tests the diamond proxy contracts and facets
- [SolidState](https://github.com/solidstate-network/solidstate-solidity) : I recommend to use this repository for ease when developing contract using diamond proxy method

- change file `.env.example` to `.env` and fill in the required env value

# Unit Testing
## Preparation
before we start doing unit testing, please run following command to generate `contracts-exposed`, this tools will allow us to check for internal functions

to test the contract run the command

```
$ npx hardhat test
```

# Tools 
- [Louper - for browsing Diamond Proxy Contracts](https://louper.dev/)

# References
- [Youtube - Basics of Diamond Contract](https://www.youtube.com/watch?v=8p4NhC9sLDA)
- [QuickNode - The Diamond Standard (EIP-2535) Explained](https://www.quicknode.com/guides/smart-contract-development/the-diamond-standard-eip-2535-explained-part-2)