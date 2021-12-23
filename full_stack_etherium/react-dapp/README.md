# Installing dependencies

```
yarn install ethers hardhat @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers
```

```
npm install --save-dev "hardhat@^2.8.0" "@nomiclabs/hardhat-waffle@^2.0.0" "ethereum-waffle@^3.0.0" "chai@^4.2.0" "@nomiclabs/hardhat-ethers@^2.0.0" "ethers@^5.0.0"
```

## Hardhat development environment

hardhat.config.js - The entirety of your Hardhat setup (i.e. your config, plugins, and custom tasks) is contained in this file.
scripts - A folder containing a script named sample-script.js that will deploy your smart contract when executed
test - A folder containing an example testing script
contracts - A folder holding an example Solidity smart contract

```

Z:\codeplay\blockchain_snippets\full_stack_etherium\react-dapp>npx hardhat run scripts/deploy.js --network localhost
Greeter deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
```

![](contract_with_app.js)