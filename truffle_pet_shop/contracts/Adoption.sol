pragma solidity ^0.5.0;

contract Adoption {
    address[16] public adopters;

    function adopt(uint petId) public returns (uint){
        require(petId >= 0 && petId <=15);

        // address of who sent the message
        adopters[petId] = msg.sender;

        return petId;
    }

    //view means the function will not modify the state of contract
    function getAdopters() public view returns (address[16] memory){
        return adopters;
    }


}