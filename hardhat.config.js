require("@nomiclabs/hardhat-waffle");

const {polygon, alchemy, privateKey} = require('./config/config.json') //Alchemy URL and Private Key in config folder



module.exports = {
  solidity: "0.8.9",
  networks: {
    polygon_mumbai: {
      url: polygon,
      accounts: [privateKey]
    },
    harmony_testnet: {
      url: 'https://api.s0.pops.one/',
      accounts: [privateKey]
    },
    rinkeby: {
      url: alchemy,
      accounts: [privateKey]
    }
  },
}