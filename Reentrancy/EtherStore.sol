//SPDX-License-Identifier:MIT
pragma solidity 0.6.10;
import "hardhat/console.sol";
contract EtherStore {
    mapping (address=>uint256) public balances;

    receive() external payable{}
    function depositFunds () public payable{
        balances[msg.sender]+=msg.value;
    }
    function withdrawFunds(uint256 amount) public {
        require(balances[msg.sender]>=amount,"Insufficient balance to withdraw !!"); 
        (bool success,)= msg.sender.call{value:amount}("");
        // require(success,"Failed to  send ethher");
        console.log("working on  balance decrese");
        balances[msg.sender]-=amount;
    }
    function getContractBalance() public view returns(uint256){
        return address(this).balance;
    }
}