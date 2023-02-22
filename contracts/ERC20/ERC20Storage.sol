// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

library ERC20Storage {
    struct Layout {
        string name;
        string symbol;
        uint256 maxSupply;
    }

    bytes32 internal constant STORAGE_SLOT =
        keccak256("solidstate.contracts.storage.ERC20Storage");

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
