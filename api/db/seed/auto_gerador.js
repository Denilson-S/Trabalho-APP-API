const { GoogleGenerativeAI } = require("@google/generative-ai");
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../../../.env') });

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-flash-lite-latest" }); 

const categories = ['Geography', 'Cinema', 'Music', 'History', 'Sport', 'TV series', 'General Knowledge', 'Science'];
const levels = ['Easy', 'Medium', 'Hard'];

// 10 perguntas * 7 lotes = 70 perguntas por nível
const perguntasPorLote = 10;
const totalDeLotes = 7; 

const delay = (ms) => new Promise(res => setTimeout(res, ms));

async function gerarCargaTotal() {
    console.log("🚀 Iniciando o Robô V3 (Carga Total - 5040 Registros)...");
    console.log("⚠️ ATENÇÃO: Este processo fará 168 requisições à IA e pode levar cerca de 40 minutos.\n");
    
    const filePath = path.join(__dirname, 'db_data.sql');

    // 1. Inicializa o arquivo (apaga o antigo e cria o cabeçalho)
    let header = '-- =========================================\n';
    header += '-- BANCO DE DADOS OFICIAL: 5040 PERGUNTAS\n';
    header += '-- =========================================\n\n';
    fs.writeFileSync(filePath, header, 'utf8');

    let totalRegistros = 0;

    for (const category of categories) {
        for (const level of levels) {
            for (let loteAtual = 1; loteAtual <= totalDeLotes; loteAtual++) {
                
                console.log(`⏳ Gerando [${category}] | Nível: [${level}] | Lote ${loteAtual}/${totalDeLotes}...`);

                // Pedimos à IA para ser criativa e não repetir perguntas dos lotes anteriores
                const prompt = `Atue como um especialista em criação de quiz. Crie ${perguntasPorLote} perguntas INÉDITAS, altamente criativas e de alta qualidade da categoria ${category} nível ${level}. 
                Evite as perguntas mais clichês.
                Retorne APENAS um array JSON válido, sem usar marcações markdown como \`\`\`json. O formato DEVE ser rigorosamente este:
                [
                  {"category": "${category}", "level": "${level}", "pt-br": {"q": "pergunta", "opt1": "f1", "opt2": "f2", "opt3": "f3", "ans": "certa"}, "en-us": {"q": "question", "opt1": "f1", "opt2": "f2", "opt3": "f3", "ans": "correct"}, "es-es": {"q": "pregunta", "opt1": "f1", "opt2": "f2", "opt3": "f3", "ans": "correcta"}}
                ]`;

                let success = false;
                let tentativas = 0;

                while (!success && tentativas < 3) {
                    try {
                        const result = await model.generateContent(prompt);
                        let text = result.response.text();
                        
                        text = text.replace(/```json/g, '').replace(/```/g, '').trim();
                        const questions = JSON.parse(text);

                        let loteValues = [];

                        questions.forEach(q => {
                            const langs = ['pt-br', 'en-us', 'es-es'];
                            langs.forEach(lang => {
                                const data = q[lang];
                                if(data) {
                                    const questionText = data.q.replace(/'/g, "''");
                                    const opt1 = data.opt1.replace(/'/g, "''");
                                    const opt2 = data.opt2.replace(/'/g, "''");
                                    const opt3 = data.opt3.replace(/'/g, "''");
                                    const answer = data.ans.replace(/'/g, "''");

                                    loteValues.push(`('${q.level}', '${q.category}', '${lang}', '${questionText}', '${opt1}', '${opt2}', '${opt3}', '${answer}')`);
                                    totalRegistros++;
                                }
                            });
                        });

                        // 2. Salva este lote direto no disco de forma segura!
                        if (loteValues.length > 0) {
                            let sqlInsert = 'INSERT INTO quizzes (quiz_level, quiz_category, quiz_language, quiz_question, quiz_option_I, quiz_option_II, quiz_option_III, quiz_answer) VALUES\n';
                            sqlInsert += loteValues.join(',\n') + ';\n\n';
                            fs.appendFileSync(filePath, sqlInsert, 'utf8');
                        }

                        success = true;
                        
                        // Pausa de 6 segundos entre requisições normais para não assustar o servidor
                        await delay(6000); 

                    } catch (error) {
                        if (error.message.includes('429')) {
                            tentativas++;
                            console.log(`   🚦 Cota cheia! O robô vai pausar por 60 segundos (Tentativa ${tentativas}/3)...`);
                            await delay(60000); // Pausa de 1 minuto inteiro na conta grátis
                        } else {
                            console.error(`   ❌ Erro de JSON (A IA formatou mal). Pulando lote...`, error.message);
                            break; // Quebrou o JSON, desiste desse lote específico e vai para o próximo
                        }
                    }
                }
            }
        }
    }

    console.log(`\n🎉 FIM DA PRODUÇÃO! O arquivo db_data.sql foi gerado com aproximadamente ${totalRegistros} perguntas!`);
}

gerarCargaTotal();