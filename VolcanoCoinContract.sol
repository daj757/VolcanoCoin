// SPDX-License-Identifier: UNLICENSED 

pragma solidity ^0.8.0;


contract VolcanoCoin {
    address owner;
    uint256 number;
    event supplyTotal(uint256);

    struct User {
        address account
        uint256 balance
    }
    constructor()  {
        number = 1000;
        owner = msg.sender;
    }
    function retrievewallet() external view returns (address) {
        if (msg.sender == owner) {
            return 0x000000000000000000000000000000000000dEaD;
        }
        return owner;
    }
     modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
    }
    function increaseSupply(uint256 num) public view onlyOwner {
       number + num;
       emit supplyTotal(number)
    }
   

    function retrieve() public view returns (uint256){
        return number;
    }
}
