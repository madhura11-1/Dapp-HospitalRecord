// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

// Explanation of how library can be used

library Median{

    function medianOfArray(uint[] storage arr) public view returns (uint){

        
        uint size = arr.length;
        if(size % 2 == 0){
            return ((arr[size/2] + arr[(size/2) -1])/2);
        }else{
            return arr[size/2];
        }

    }
}

contract LibraryDemo{

    uint[] arr;

    constructor() public{
        arr.push(1);
        arr.push(2);
        arr.push(2);
        arr.push(5);
    }


    /**
        @dev Get the Median of an array
        @return uint Returns the median of the array
    */
    function getMedian() public view returns(uint){

        uint median = Median.medianOfArray(arr);
        return median;

    }

}