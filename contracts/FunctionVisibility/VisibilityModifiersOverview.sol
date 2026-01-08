contract VisibilityModifiersOverview {
    //in this contract we will overview function visibilities who can access and who cannot

    //public type visibility in a fucntion means anyone can see and call the function can  be dagnerous and vulnerable to exploit if it is not intended for the users to use or call
    function _getNumPublic() public returns (uint) {
        return 2;
    }

    //private means users cannot access or see and can only be used in the contract it is made in in this case can only be called here
    function __getNumPrivate() private returns (uint) {
        return 2;
    }

    // internal functions is like family privlages only the contract its made in can call it and contracts that inherit the contract with the internal ,

    function _getNumInternal() internal returns (uint) {
        return 2;
    }

    //external can only be called from outside the contract parameters are non modifiable but can be stored

    function _getNumExternal() external returns (uint) {
        return 2;
    }

    //public view means its public can be calle dby anoneone and is a read only function cant update blockchain or contracts state

    function _getNumPublicView() public view returns (uint) {
        return 2;
    }

    //public pure means can only ue parameters and values and variables within the function itself cannot access outside values in the contract
    //the pure key  basically like making a box only whats within the box u can use u cant use whats outside of the box
    function _getNumPublicPure(
        uint256 _a,
        uint256 _b
    ) public pure returns (uint256) {
        return _a * _b; // Pure calculation, no state interaction
    }
}
//when making a function visibility and think about which visibility should be important as a developer

// view read only blockchain or contract state is not hanged describes a readonly type of funciton
// pure only uses parameters passed in and values within the fucntion itself cannot access outside vlues or variables - could be possibly gas efficient when needed

//function visibility types - u can add view and pure to these if u have to or want to u shold
//public can be called by anyone and anything good and dangerous at the same time
//private can only be called from witihin the contract it is made in
//external can only be called from outside the contract parameters are non modifiable but can be stored
// internal functions is like family privlages only the contract its made in can call it and contracts that inherit the contract with the internal ,
//fucntion can use it

//every single detain in a contract is important in regards to having a gas efficient contract
