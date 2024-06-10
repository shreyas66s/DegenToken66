// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20,ERC20Burnable, Ownable {
    mapping(address => string) public redeemed_car;
    string[] public car_array;
    string public car_showroom;

    constructor() ERC20("Degen", "DGN") {
        car_showroom = "In our showroom we have : 1. Mercedes AMG GT , 2. Lamborghini Aventador, 3. Ferrari SF90 ";
        car_array=["Mercedes AMG GT","Lamborghini Aventador","Ferrari SF90"];
        
    }

    function mint(address _address, uint256 value) public onlyOwner {
        _mint(_address, value);
    }

    function burn(uint256 value) public override {
        _burn(msg.sender, value);
    }

    function transfer(address recipient, uint256 value) public override returns (bool) {
        _transfer(msg.sender, recipient, value);
        return true;
    }

    function redeem(uint256 car_id) public {
        require(car_id > 0 && car_id < 4, "There are only three cars in our showroom");
        if(balanceOf(msg.sender) <= 300000){
            revert("Insufficent funds to redeem. Should be greater than 300000");
        }
        _burn(msg.sender, 100000 * car_id);
        redeemed_car[msg.sender]=car_array[car_id-1]; 
        
    }   
}
