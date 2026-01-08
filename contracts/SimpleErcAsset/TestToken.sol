// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//we use the is ERC20 so we can use all the functions in the ERC20 contract straightforward
//EVERYTHING IS DONE ALL WE GOTTA DO IS TEST AND DEBUG!

contract TestToken is ERC20 {
    struct BalanceHistoryLog {
        uint256 _balance;
        uint256 _logTimestamp;
    }

    struct TokenInfo {
        string _name;
        string _symbol;
        uint256 _totalSupply;
        uint256 _userBalance;
    }
    address public owner;
    mapping(address => BalanceHistoryLog[]) public balanceHistory;
    //every time tokens get minted emit event with amount and time of mint
    event _tokensMinted(uint256 _amount, uint256 _timestamp);
    event _tokensTransferred(address _to, uint256 _amount);
    uint256 public _totalSupply;

    string public _name;
    string public _symbol;

    // /modifiers can be attached to functions so that it only runs if the criteria in the modifier is met
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Must be owner to excecute this transaction!"
        );

        _;
    }

    //in the constructor at the top block we initialize and call ERC20 contract and pass in the required arguments for its constructor
    //this is how we use ERC20 fully ERC20 does the rest we add custom stuff if we want to its as easy as it is straight out of the pakcage
    //parameters passed in our constructor then passed in erc20 constructor no type is put in erc20 constructor just param variable names
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 _supply
    ) ERC20(name_, symbol_) {
        //mint 1000000 for the deploer of this contract which is me
        _name = name_;
        _symbol = symbol_;
        owner = msg.sender;
        _totalSupply = _supply;
        _mint(msg.sender, _totalSupply);

        //emits the event that tokens were mintedgl
        //these tokens are minted when tokens are deployed
        emit _tokensMinted(_totalSupply, block.timestamp);
    }

    //we use calldata since the values wil be read only so it makes the excecution process more gas efficient for users
    //pay less gas for the transaction
    function _batchTransfer(
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) public {
        for (uint256 i = 0; i < _addresses.length; i++) {
            //to, value
            //transfers tokens at given index for address and given index for amount
            //i think we need another transfer function to call this examine openzepplins github repo
            //we use transfer from it automatically updates approvals for spending
            //logic anyone  can send to multiple wallets at once
            transferFrom(msg.sender, _addresses[i], _amounts[i]);
            //update balance history for user max limit 3 balance history logged for each user 3 history limit
            _updateHistory(_addresses[i], _amounts[i]);
            //emits event that tokens were indeed transferred to the wallet at the given index
            emit _tokensTransferred(_addresses[i], _amounts[i]);
        }
    }

    //memeory is best because it stores storage as memeory when its a public view function that only reads and returns value calldata wont work  this is best
    //balance history
    function _getHistory(
        address _account
    ) public view returns (BalanceHistoryLog[] memory) {
        return balanceHistory[_account];
    }

    //give a look at all functions and make sure the right visibility is applied not all functions need to be seen by users
    //update baalnce history
    //only happens interlly users cant access
    //this is whats left to be done find a way this logic can be used for this function
    function _updateHistory(address _account, uint256 _balance) internal {
        //if 3 exists we must find a way to shift and update with latest being last index
        BalanceHistoryLog memory _newValue = BalanceHistoryLog(
            _balance,
            block.timestamp
        );
        if (balanceHistory[_account].length == 3) {
            //since limit length for history logs for each users manually shifting the array is more efficient
            //if there are three values shift aray and add latest to the last index
            balanceHistory[_account][0] = balanceHistory[_account][1];
            balanceHistory[_account][1] = balanceHistory[_account][2];
            balanceHistory[_account][2] = _newValue;
        } else {
            //push to array normal way add latest to last index
            balanceHistory[_account].push(_newValue);
        }
    }

    function _getTokenInfo() public view returns (TokenInfo memory) {
        //returns struct with token info it will return an array
        //example of making and returnng struct
        //return TokenInfo(_name, _symbol, _supply)
        uint256 _userBalance = balanceOf(msg.sender);
        //if its private in another contract we must store variable and its value in this contract make it public
        TokenInfo memory _info = TokenInfo(
            _name,
            _symbol,
            _totalSupply,
            _userBalance
        );

        return _info;
    }
}

// # ERC20 Token Project - "MyFirstToken"

// ## Goal
// Build a token demonstrating all learned concepts

// ---

// ## Requirements
// done
// ### 1. Setup (Inheritance + Constructor) DONE
// - [ ] Inherit from OpenZeppelin ERC20
// - [ ] Constructor: hardcode name/symbol, mint initial supply to deployer

// ### 2. Mint Function (Visibility + State) DONE
// - [ ] `mint(address, uint256)` - public but owner-only
// - [ ] Creates new tokens permanently
// - [ ] Emit `Minted` event

// ### 3. Batch Transfer (Calldata vs Memory) DONE
// - [ ] `batchTransfer(address[] calldata, uint256[] calldata)`
// - [ ] Transfer to multiple addresses at once
// - [ ] Use calldata for gas efficiency
// - [ ] Emit event for each transfer

// ### 4. Balance History (State Persistence) DONE
// - [ ] Track last 3 balance changes per user with timestamps
// - [ ] `getBalanceHistory(address)` returns history
// - [ ] Data persists across transactions

// ### 5. Token Info (No Async) DONE
// - [ ] `getTokenInfo()` returns name, symbol, totalSupply, yourBalance
// - [ ] View function - one synchronous call

// ### 6. Internal Helper (Visibility) DONE
// - [ ] `_updateHistory(address, uint256)` - internal only
// - [ ] Can't be called externally

// ---
