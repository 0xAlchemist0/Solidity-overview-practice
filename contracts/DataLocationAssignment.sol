contract DataLocationsAssignment {
    //gas comparison among different data location types

    //for the calldatasum functionif u test gas is cheaper because we only read the parameter and dont store it
    //we just read and sum up each index
    function callDataSum(uint256[] calldata numList) public returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numList.length; i++) {
            sum += numList[i];
        }
        return sum;
    }

    //in memorySum function gas is more expensiv since we are storing the numList array in a temporary memory type variable variable
    function memorySum(uint256[] calldata numList) public returns (uint256) {
        uint256[] memory modifiableList = numList;
        uint256 sum = 0;
        for (uint256 i = 0; i < modifiableList.length; i++) {
            sum += numList[i];
        }
        return sum;
    }
}

//results
// calldata gas for transaction:  23819n
// memory gas for transaction:  24018n
//comparing data storage gas
