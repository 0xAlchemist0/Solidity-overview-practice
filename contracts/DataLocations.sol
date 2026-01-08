// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

//reference: https://solidity-by-example.org/data-locations/

///storage, memory, and calldata, functions and function visibility overview
//to get how much gas would cost for example in a function call we use tx.gasprice to get the gas price
//

contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;

    struct MyStruct {
        uint256 foo;
    }
    mapping(uint256 => MyStruct) myStructs;

    function f() public returns (uint) {
        // call _f with state variables
        _f(arr, map, myStructs[1]);
        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);

        return tx.gasprice;
    }

    function _f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal returns (uint) {
        // reading storage variables
        uint256 arrLength = _arr.length;

        return tx.gasprice;
    }

    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // return the memory array
        return _arr;
    }

    function h(uint256[] calldata _arr) external returns (uint) {
        // read calldata array
        uint256 firstElement = _arr[0];

        return tx.gasprice;
    }
}

//-----------------------------------------------------------------------------------------
//Datalocations:

//note data location types can only be specificed for array, strcuts or mapping types

//memory is used to store temporary data that is only need for example the the case where u call and function and only need it for that call
//memory- for memory once a call is excecuted for example a function the memory space used up from that memory vriable is freed up making it gas efficient
//its basically like a item u buy and u throw it out in the trash when u dont need it anymore

//calldata is a value/variable that is passed into a fucntion u can only read that value but not modify it

//storage: it is permanent on the blockchain the arr variable is an example of a storage it says forever u can update change or whatever but stays forever on the blockchain
//storage always exists outside of the function within the contract

//That's the key difference: Storage survives the function. Memory doesn't.

//in a sense you can use these data locations together for example:
//lets say u pass in a calldata array into a function remmebr we cant modify it
//so if u would want to modify it u can store it in a memory type datalocation variable (see you can work with multiple data locations at the same time)
//u mst be careful tho as gas gets more expensie

//-----------------------------------------------------------------------------------------------

//function visibility types
//public can be called by anyone and anything good and dangerous at the same time
//private can only be called from witihin the contract it is made in
//external can only be called from outside the contract parameters are non modifiable but can be stored
// internal functions is like family privlages only the contract its made in can call it and contracts that inherit the contract with the internal ,
//fucntion can use it
