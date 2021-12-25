//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string public name = "ashjp token";
    string public symbol = "NDT";
    uint public totalSupply = 1000000;
    string private once;
    mapping(address=>uint) balances;

    constructor(string memory _once)
    {
        once = _once;
        console.log("Deploying a Token with ", _once);
        balances[msg.sender] = totalSupply;
    }

    function warcry() public view returns (string memory) {
        return once;
    }

    function transfer(address to, uint amount) external {
        require(balances[msg.sender] >= amount, "Not enough tokens");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint){
        return balances[account];
    }
}

