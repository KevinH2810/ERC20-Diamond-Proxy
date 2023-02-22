// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./ERC20Storage.sol";
import "@solidstate/contracts/token/ERC20/base/IERC20BaseInternal.sol";
import "@solidstate/contracts/token/ERC20/base/ERC20BaseInternal.sol";

contract ERC20Internal is IERC20BaseInternal, ERC20BaseInternal {
    /**
     * @notice mint tokens for given account
     * @dev to override original _mint method
     * @dev to check wheter if totalSupply + amount is >= maxSupply
     * @param account recipient of minted tokens
     * @param amount quantity of tokens minted
     */
    function _mint(address account, uint256 amount) internal override {
        ERC20Storage.Layout storage layout = ERC20Storage.layout();
        ERC20BaseStorage.Layout storage l = ERC20BaseStorage.layout();

        require(layout.maxSupply >= _totalSupply() + amount);
        if (account == address(0)) revert ERC20Base__MintToZeroAddress();

        l.totalSupply += amount;
        l.balances[account] += amount;

        emit Transfer(address(0), account, amount);
    }

    function _setName(string memory _name) internal {
        ERC20Storage.layout().name = _name;
    }

    function _setSymbol(string memory _symbol) internal {
        ERC20Storage.layout().symbol = _symbol;
    }

    function _setMaxSupply(uint256 _maxSupply) internal {
        ERC20Storage.layout().maxSupply = _maxSupply;
    }
}
