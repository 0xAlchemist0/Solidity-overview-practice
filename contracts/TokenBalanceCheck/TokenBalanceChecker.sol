//here we import the interface we are gonna use to interact ith the usd cntract

import "./IUsdc.sol";

contract TokenBalanceChecker {
    //the best way to interact with deploed contracts on mainet is using interfaces
    //there are other ways to interact with contracts depeding on the situation or u can use multiple methods in the same contract o use a contract
    // for example:
    //if  u made the contract ( lets say u have a contract with a fucntion called foo) u can call foo like this:
    //address myContract = 0x123...;
    //myContract.fo()
    //this is how u can call ur own contract
    //but for this example we will use interfaces to get balances from a real deployyed on mainet contract that i did not make
    //someoen else on the blockchain made it
    //we weill use Ethereum mainnet usdc contract for this example to get a users balance on a chain

    //this is the variable we will use to interact witht he usd contract from the IUsdc interface
    //the type o fthe variable must be of type of the interface
    IUsdc USDC;

    //RIGHT WAY, RIGHT WAY, RIGHT WAY:
    //constructor is the initial instructions the contract does whe its first depolyed
    constructor(address USDCAddress) {
        //here we set the address of the contract that contains the fucntions in the interface
        //basically the address that implements it and the one we wanna use in this situation we will pass in 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
        USDC = IUsdc(USDCAddress);
    }

    //RIGHT WAY, RIGHT WAY, RIGHT WAY:
    //this functino is the right way of using other deployed contracts thats not yours
    function getBalance(address _user) public returns (uint256) {
        uint256 _balance = USDC.balanceOf(_user);

        return _balance;
    }

    //WRONG WAY , WRONG WAY, WRONG WAY, WRONG WAY :
    //this will result in an error i put this function here to show that we need a interface to be able to call and get balance
    //this methodology below only works if u made the contract urself and imported it in this contract

    // function getBalanceNoInterface() public returns (uint256) {
    //     address usdcAddy = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    //     return usdcAddy.balanceOf(0xe1940f578743367F38D3f25c2D2d32D6636929B6);
    // }
}

//everything works fine here
//used binance address toget its balance in the hardhat test
//this the wallet we track usdc balance 0xe1940f578743367F38D3f25c2D2d32D6636929B6
//example output on hardhat test User USDC Balance:  1399999999009577n
