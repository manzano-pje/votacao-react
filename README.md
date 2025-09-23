# 🗳️ Voting DApp

## 📖 Descrição do Sistema

Este projeto é um sistema de votação **descentralizado**, simples e seguro, desenvolvido em **Solidity**.  
Ele demonstra um fluxo completo de eleição, desde o cadastro de candidatos até a divulgação do vencedor, garantindo **transparência e imutabilidade** através da tecnologia **blockchain**.

## ⚡ Funcionalidades
- **Cadastro de Candidatos:** O dono do contrato pode cadastrar novos candidatos, associando um nome a cada um.  
- **Votação:** Os eleitores interagem com o contrato para registrar seu voto. O sistema garante que cada eleitor só vote uma vez.  
- **Anúncio do Vencedor:** O contrato calcula automaticamente o vencedor, exibindo o nome e a quantidade total de votos.  

## 🛠 Tecnologias Utilizadas
- **Solidity** – Contrato inteligente.  
- **Foundry** – Compilação, testes e deploy.  
- **Web3.js + Node.js/Express** – API de integração.  
- **Swagger / Postman** – Testes e documentação da API.  
- **Sepolia Testnet** – Rede de teste Ethereum.  

## 🔄 Fluxo de Votação
1. O dono do contrato inicia a eleição cadastrando candidatos.  
2. Eleitores registram votos (um por conta).  
3. O sistema processa e publica o resultado de forma imutável.  

## ▶️ Executando o Projeto
Clone o repositório e configure as variáveis de ambiente para conectar-se à rede blockchain:  

```bash
git clone https://github.com/manzano-pje/votacao.git
cd votacao
npm install
node index.js
```

A API ficará disponível em **http://localhost:3000**.

## 📂 Estrutura do Projeto

```
Voting/
 ├── contracts/        # Contratos Solidity (Voting.sol)
 ├── voting-api/       # API Node.js para interagir com o contrato
 ├── artifacts/        # ABI e bytecode gerados após compilação
 └── README.md         # Documentação
```

## 🚀 Entregáveis
- `Voting.sol`  
- ABI do contrato  
- Endereço do contrato na Sepolia  
- 🎥 Vídeo mostrando API + integração funcionando  

---
👨‍💻 Desenvolvido por Paulo Manzano
