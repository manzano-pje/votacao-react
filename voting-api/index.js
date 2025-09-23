const express = require("express");
const bodyParser = require("body-parser");
const votingService = require("./votingService");
const setupSwagger = require("./swagger");

// Criar o app Express
const app = express();
app.use(bodyParser.json());

// Configurar Swagger
setupSwagger(app);

/**
 * @swagger
 * /candidates:
 *   get:
 *     summary: Lista todos os candidatos
 *     responses:
 *       200:
 *         description: Lista de candidatos com votos
 */
app.get("/candidates", async (req, res) => {
    try {
        const candidates = await votingService.getCandidates();
        res.json(candidates);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/**
 * @swagger
 * /candidates:
 *   post:
 *     summary: Adiciona um novo candidato (somente owner)
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *     responses:
 *       200:
 *         description: Candidato adicionado
 */
app.post("/candidates", async (req, res) => {
    try {
        const { name } = req.body;
        const msg = await votingService.addCandidate(name);
        res.json({ message: msg });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/**
 * @swagger
 * /vote:
 *   post:
 *     summary: Vota em um candidato
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               candidateIndex:
 *                 type: integer
 *               voterPrivateKey:
 *                 type: string
 *     responses:
 *       200:
 *         description: Voto registrado
 */
app.post("/vote", async (req, res) => {
    try {
        const { candidateIndex, voterPrivateKey } = req.body;
        const msg = await votingService.vote(candidateIndex, voterPrivateKey);
        res.json({ message: msg });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/**
 * @swagger
 * /winner:
 *   get:
 *     summary: Retorna o vencedor
 *     responses:
 *       200:
 *         description: Nome do vencedor
 */
app.get("/winner", async (req, res) => {
    try {
        const winner = await votingService.getWinner();
        res.json({ winner });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(3000, () => console.log("API rodando em http://localhost:3000"));
