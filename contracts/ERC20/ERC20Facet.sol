// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@solidstate/contracts/token/ERC20/base/ERC20Base.sol";
import "@solidstate/contracts/interfaces/IERC20.sol";
import "@solidstate/contracts/access/ownable/Ownable.sol";
import "./ERC20Internal.sol";

//the basic implementation of ERC20 token using predefined function of solidState-Solidity contract
// refer to : https://github.com/solidstate-network/solidstate-solidity/blob/master/contracts/token/ERC20/base/ERC20Base.sol
contract ERC20Facet is ERC20Internal, IERC20, Ownable {
    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint256 maxSupplyToken
    ) {
        _setName(tokenName);
        _setSymbol(tokenSymbol);
        _setMaxSupply(maxSupplyToken);
        _setOwner(msg.sender);
    }

    /**
     * @inheritdoc IERC20
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply();
    }

    /**
     * @inheritdoc IERC20
     */
    function balanceOf(address account) external view returns (uint256) {
        return _balanceOf(account);
    }

    /**
     * @inheritdoc IERC20
     */
    function allowance(address holder, address spender)
        external
        view
        returns (uint256)
    {
        return _allowance(holder, spender);
    }

    /**
     * @inheritdoc IERC20
     */
    function approve(address spender, uint256 amount) external returns (bool) {
        return _approve(msg.sender, spender, amount);
    }

    /**
     * @inheritdoc IERC20
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        return _transfer(msg.sender, recipient, amount);
    }

    /**
     * @inheritdoc IERC20
     */
    function transferFrom(
        address holder,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        return _transferFrom(holder, recipient, amount);
    }

    /// @dev we will allow owner to mint the token for people
    /// @dev for cases such as airdrops, etc
    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function getTokenName() external view returns (string memory) {
        return ERC20Storage.layout().name;
    }

    function getTokenSymbol() external view returns (string memory) {
        return ERC20Storage.layout().symbol;
    }

    function getTokenMaxSupply() external view returns (uint256) {
        return ERC20Storage.layout().maxSupply;
    }
}
