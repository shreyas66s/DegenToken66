// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    struct Item {
        string name;
        uint256 price;
        uint256 quantity;
    }

    mapping(uint256 => Item) public redeemableItems;
    uint256[] public itemIds;
    mapping(address => string) public redeemedCar;
    string public carShowroom;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        carShowroom = "In our showroom we have: 1. Mercedes AMG GT, 2. Lamborghini Aventador, 3. Ferrari SF90";
        addItem(1, "Mercedes AMG GT", 100000,2);
        addItem(2, "Lamborghini Aventador", 200000,1);
        addItem(3, "Ferrari SF90", 300000,2);
    }

    function addItem(uint256 itemId, string memory name, uint256 price,uint _quantity) public onlyOwner {
        require(redeemableItems[itemId].price == 0, "Item already exists");
        redeemableItems[itemId] = Item(name, price,_quantity);
        itemIds.push(itemId);
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

    function redeem(uint256 itemId) public {
        Item memory item = redeemableItems[itemId];
        require(item.price > 0, "Item does not exist");
        require(item.quantity > 0, "Item is out of stock");
        require(balanceOf(msg.sender) >= item.price, "Insufficient funds to redeem");

        _burn(msg.sender, item.price);
        item.quantity--;
        redeemedCar[msg.sender] = item.name;
    }

    function getRedeemableItems() public view returns (Item[] memory) {
        Item[] memory items = new Item[](itemIds.length);
        for (uint256 i = 0; i < itemIds.length; i++) {
            items[i] = redeemableItems[itemIds[i]];
        }
        return items;
    }
}
