require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    rinkeby: {
      url: process.env.SEPOLIA_PRIVATE_KEY,
      accounts: [process.env.INFURA_API_KEY],
    },
  },
};


