contract EventsDemonstration {
    //how events work you emit an event the _sumexcecuted event listens when its event is called in any funciton or anywhere in the contract
    //these events are logged on the blockchain when a transaction is made so user can see what event is emmited when done
    //hre is how we create an event
    event _sumExcecuted(uint256 _excecutionTimestamp, uint256 gasToPay);
    uint256 sum = 0;

    function _makeSum(uint256 uintA, uint256 uintB) public {
        uint256 _numToAdd = 80;
        sum = _numToAdd + uintA + uintB;
        //here is how we call the event by using the emit key followed by the speicifc even and passing in the required parameters

        emit _sumExcecuted(block.timestamp, tx.gasprice);
    }
}
