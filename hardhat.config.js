require("@nomiclabs/hardhat-waffle");

const config = require('./config/config.json') //Alchemy URL and Private Key in config folder



// module.exports = {
//   solidity: "0.8.4",
//   networks: {
//     rinkeby: {
//       url: config.alchemy,
//       accounts: [config.privateKey]
//     }
//   }
// };


module.exports = {
  solidity: "0.8.9",
  defaultNetwork: "polygon_mumbai",
  networks: {
     polygon_mumbai: {
        url: config.polygon,
        accounts: [config.privateKey]
     }
  },
}