const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

process.env.TZ = process.env.TZ || 'UTC';

const express = require('express');
const cors = require('cors');
const routes = require('./routes');

const app = express();
app.use(express.json());

app.use('/api', routes);
app.use(cors());

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`✅ API do Quizz rodando na porta: ${PORT} (Timezone: ${process.env.TZ})`);
});