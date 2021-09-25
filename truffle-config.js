
const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config()
const MNEMONIC = process.env.MNEMONIC
const API_KEY = process.env.MATIC_APP_ID
const POLYSCAN = process.env.POLYSCAN
module.exports = {
  api_keys: {
    polygonscan: POLYSCAN,
  },
  //* run with 'npx' prefix
  plugins: [
    'truffle-plugin-verify'
  ],
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      gas: 5000000,
      network_id: "*", // Match any network id
    },
    mumbai: {
      provider: function () {
        return new HDWalletProvider(MNEMONIC, `https://rpc-mumbai.maticvigil.com/v1/${API_KEY}`);
      },
      network_id: 80001,
      confirmations: 2,
      skipDryRun: true
    },
    matic: {
      provider: function () {
        return new HDWalletProvider(MNEMONIC, `https://rpc-mainnet.maticvigil.com/v1/${API_KEY}`);
      },
      network_id: 137,
      gas: 5000000,
      gasPrice: 5000000000,
      confirmations: 2,
    },
  },
  compilers: {
    solc: {
      version: "0.8.2",

    }
  },
  db: {
    enabled: false
  }
};
