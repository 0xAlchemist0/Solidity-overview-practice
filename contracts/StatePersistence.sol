contract StatePersistence {
    ///in this example we show how data can be stored in the blockchain and we can update all the time if we want to remmebr updating
    //updating blockchain state and variabes that stay forever can be gas expensive

    uint256 public times_called = 0;
    uint256[] public timestamp_collection;

    function _logFunctionCall() public {
        times_called += 1;
    }

    function _collectTimestamp() public {
        timestamp_collection.push(block.timestamp);
    }

    //
    function _callFunction() public {
        _logFunctionCall();
        _collectTimestamp();
    }

    function _getTimesCalled() public view returns (uint256) {
        return times_called;
    }

    function _getTimestamps(
        uint256 limit
    ) public view returns (uint256[] memory) {
        require(
            limit <= timestamp_collection.length,
            "ERROR LIMIT IS LARGER THAN ARRAY LENGTH!"
        );
        ////////////////////////
        uint256[] memory tempList = timestamp_collection;
        //since the aray isnt intialied and we cant use .push either with values something that is in memory must be initialized to a fixed length
        //here we set the length of the array to limit to be able to add value at index
        uint256[] memory limitedList = new uint256[](limit);
        //when the array is of memory type we cannot push we set at given index else we get this error: Member "push" is not available in uint256[] memory outside of storage.
        for (uint256 i = 0; i < limit; i++) {
            limitedList[i] = tempList[i];
        }

        return limitedList;
    }
}
