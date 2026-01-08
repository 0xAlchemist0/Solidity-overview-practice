// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract VaultToken is ERC20 {
    uint256 _totalSupply = 1000000;
    //token minted  event
    event TokensMinted(uint256 _mintAmount, uint256 _mintTimestamp);
    //token transfer event
    event TokensTransfered(
        uint256 _amountTransfered,
        uint256 _transferTimestamp
    );
    string public _name;
    string public _symbol;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
        //mint supply to dev wallet
        _mint(msg.sender, _totalSupply);
        //emit event supply was mitned
        emit TokensMinted(_totalSupply, block.timestamp);
    }
}

// CONTRACT 2: VAULT
// VAULT PROJECT

// Build a vault contract that:

// Accepts an ERC20 token address (like USDC) in the constructor
// Allows users to deposit that specific token into the vault
// Tracks each user's deposited balance in the vault
// Allows users to withdraw their deposited tokens
// Emits an event when deposits happen
// Emits an event when withdrawals happen
// Has a function to check any user's current balance in the vault
// Has a function to check the vault's total token holdings
// Calls the external ERC20 token contract to transfer tokens in and out
// Uses appropriate visibility modifiers (public, private, internal, external)
// Uses appropriate data locations (storage, memory, calldata) where needed
// Persists all balances and state between transactions
// Handles the ERC20 approval pattern correctly (users approve before depositing)

// The contract should have these capabilities:

// User calls deposit(amount) → vault transfers tokens from user → updates user balance → emits event
// User calls withdraw(amount) → vault checks balance → transfers tokens back → updates user balance → emits event
// Anyone can view balances and vault totals
// State data never resets between function calls
