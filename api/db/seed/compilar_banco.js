const fs = require('fs');
const path = require('path');

// Lê o arquivo JSON que está na MESMA pasta que este script
const rawData = fs.readFileSync(path.join(__dirname, 'perguntas_reais.json'));
const questions = JSON.parse(rawData);

let sqlContent = '-- =========================================================\n';
sqlContent += '-- ARQUIVO DE SEED: PERGUNTAS DE ALTA QUALIDADE\n';
sqlContent += '-- =========================================================\n\n';
sqlContent += 'INSERT INTO quizzes (quiz_level, quiz_category, quiz_language, quiz_question, quiz_option_I, quiz_option_II, quiz_option_III, quiz_answer) VALUES\n';

const values = [];

questions.forEach(q => {
    const langs = ['pt-br', 'en-us', 'es-es'];
    
    langs.forEach(lang => {
        const data = q[lang];
        const questionText = data.q.replace(/'/g, "''");
        const opt1 = data.opt1.replace(/'/g, "''");
        const opt2 = data.opt2.replace(/'/g, "''");
        const opt3 = data.opt3.replace(/'/g, "''");
        const answer = data.ans.replace(/'/g, "''");

        const valueLine = `('${q.level}', '${q.category}', '${lang}', '${questionText}', '${opt1}', '${opt2}', '${opt3}', '${answer}')`;
        values.push(valueLine);
    });
});

sqlContent += values.join(',\n') + ';';

// Salva o db_data.sql na MESMA pasta (api/db/seed/) sobrescrevendo o antigo
fs.writeFileSync(path.join(__dirname, 'db_data.sql'), sqlContent, 'utf8');

console.log(`✅ Sucesso! Geramos ${values.length} registros no arquivo db_data.sql.`);