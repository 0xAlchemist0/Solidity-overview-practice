//this is how we make a interface

//interface is basically the structure of the contract we are using to interact

//u dotn have to include all fucntions in the contracts u can ust include the ones that u will use in ur cotnract

//functions in interfaces must always be declared as external
//it is external by nature because when we call this function we are calling this function outside of its original contract
//external means we can only call it from outside of the contract not within
//we cant call it public because we dont use this function within this interface contract
interface IUsdc {
    function balanceOf(address account) external returns (uint256);
}
