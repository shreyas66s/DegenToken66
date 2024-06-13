# DegenToken Project

This project deploys an ERC20 token called "DegenToken" on the Avalanche Fuji Testnet. It demonstrates how to mint, burn, transfer tokens, and includes a special feature where users can redeem tokens for luxury cars.

## Description

DegenToken is an ERC20 token built using the OpenZeppelin library. The contract allows the owner to mint tokens, and any holder to burn their tokens. Additionally, users can transfer tokens to other addresses. A unique feature of DegenToken is the ability for users to redeem their tokens for luxury cars listed in a virtual showroom. Each car requires a certain amount of tokens to be redeemed, which are then burned from the user's balance.

## Getting Started

### Installing

# Clone the repository:
git clone https://github.com/shreyas66s/degentoken.git

cd degentoken

# Install dependencies:
npm install

# Set up environment variables:

* Create a .env file in the root directory.
* Add your private key and Snowtrace API key:
  
PRIVATE_KEY=your_private_key

SNOWTRACE_API_KEY=your_snowtrace_api_key


### Executing program

# Deploy the contract:

npx hardhat run scripts/deploy.js --network fuji


# Verify the contract on Snowtrace:

npx hardhat verify --network fuji 0xYourContractAddress

# Interacting with the contract:

* Mint tokens:

npx hardhat console --network fuji

const DegenToken = await ethers.getContractFactory("DegenToken");

const degentoken = await DegenToken.attach("0xYourContractAddress");

await degentoken.mint("0xRecipientAddress", 1000);

* Burn tokens:

await degentoken.burn(100);

* Transfer tokens:

await degentoken.transfer("0xRecipientAddress", 500);

* Redeem a car:

await degentoken.redeem(1); // Redeems the first car in the showroom


## Help

If you encounter common problems or issues, try the following:

* Ensure your .env file is correctly set up with the appropriate keys.
* Check the network configuration in the hardhat.config.js file.
* Make sure you have sufficient funds in your wallet to cover gas fees.
For additional help, refer to the Hardhat documentation or use the command below for more information:

npx hardhat help

## Authors

S Shreyas

[shreyas1665@gmail.com}


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
