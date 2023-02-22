// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@solidstate/contracts/proxy/diamond/SolidStateDiamond.sol";

/// @dev This is the main Diamond Proxy Contract
/// @dev where our Facets contract functions will be linked in here using loupers.dev
/// @dev we let it blank because the contract already inherits from SolidStateDiamond contract all the function required for Diamond Contract to work properly

contract DiamondProxy is SolidStateDiamond {

}
