const Web3 = require("web3");
require("dotenv").config();
const abi = require("../abi/Voting.json").abi;
const web3 = new Web3(new Web3.providers.HttpProvider(process.env.RPC_URL));
const account = web3.eth.accounts.wallet.add(process.env.PRIVATE_KEY);
const contract = new web3.eth.Contract(
  abi,
  process.env.CONTRACT_ADDRESS
);

module.exports = { web3, contract, account };

