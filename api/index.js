const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const express = require('express');
const routes = require('./routes');

const app = express();
app.use(express.json());

app.use('/api', routes);

app.listen(process.env.API_PORT, () => {
    console.log(`🚀 API do Quizz rodando na porta:${process.env.API_PORT}`);
});