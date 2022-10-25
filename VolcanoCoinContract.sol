// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract VolcanoCoin is ERC20, Ownable {

    struct Payment{
        address recipient;
        uint amount;
    }

    Payment payment;
    uint totalSupply = 10000;
    mapping(address => Payment[]) public payments;

    event supply_increase(uint);
    event token_transfer(address, uint);

    constructor() ERC20("VolcanoCoin", "VOL"){
        _mint(msg.sender, 10000);
    }

    function getTotalSupply() public view returns (uint){
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit supply_increase(totalSupply);
    }

    function transfer(address _transferToAddress, uint _amount) public virtual override returns (bool) {
        _transfer(msg.sender, _transferToAddress, _amount);
        
        emit token_transfer(_transferToAddress, _amount);
        
        createPaymentRecord(msg.sender, _transferToAddress, _amount);
        
        return true;
    }
    
    function createPaymentRecord(address _senderAddr, address _recipientAddr, uint _amountSent) private {
        payment.recipient = _recipientAddr;
        payment.amount = _amountSent;
        
        payments[_senderAddr].push(payment);
    }
    
    function mintTokens(uint _numberOfTokens) public onlyOwner {
        _mint(msg.sender, _numberOfTokens);
    }
}
