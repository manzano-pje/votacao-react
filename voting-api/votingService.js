const Web3 = require("web3");
require("dotenv").config();
const fs = require("fs");
const path = require("path");

// Provider da blockchain (Anvil, Ganache ou testnet)
const web3 = new Web3(process.env.RPC_URL);

// ABI do contrato
const abi = JSON.parse(fs.readFileSync(path.join(__dirname, "../Voting/out/Voting.sol/Voting.json"))).abi;
const contractAddress = process.env.CONTRACT_ADDRESS;

// Conta do deployer (proprietário)
const ownerAccount = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);
web3.eth.accounts.wallet.add(ownerAccount);

// Instância do contrato
const contract = new web3.eth.Contract(abi, contractAddress);

/**
 * Adiciona um candidato (somente owner)
 */
async function addCandidate(name) {
    const tx = contract.methods.addCandidate(name);
    const gas = await tx.estimateGas({ from: ownerAccount.address });
    await tx.send({ from: ownerAccount.address, gas });
    return "Candidato adicionado!";
}

/**
 * Vota em um candidato (votante passa privateKey)
 */
async function vote(candidateIndex, voterPrivateKey) {
    const voterAccount = web3.eth.accounts.privateKeyToAccount(voterPrivateKey);
    web3.eth.accounts.wallet.add(voterAccount);

    const tx = contract.methods.vote(candidateIndex);
    const gas = await tx.estimateGas({ from: voterAccount.address });
    await tx.send({ from: voterAccount.address, gas });

    return "Voto registrado!";
}

/**
 * Lista candidatos com quantidade de votos
 */
async function getCandidates() {
    const candidates = await contract.methods.getCandidates().call();
    // candidates provavelmente já é um array de objetos { name, votes }
    return candidates.map(c => ({
        name: c.name,
        votes: parseInt(c.votes) || 0
    }));
}

/**
 * Retorna o vencedor
 */
async function getWinner() {
    const winner = await contract.methods.getWinner().call();
    return winner;
}

module.exports = { addCandidate, vote, getCandidates, getWinner };
