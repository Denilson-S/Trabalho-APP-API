const pool = require('./db/db');

// 1. OBTER CATEGORIAS
const getCategories = async (req, res) => {
    try {
        const result = await pool.query('SELECT DISTINCT quiz_category FROM quizzes ORDER BY quiz_category');

        const categories = result.rows.map(row => row.quiz_category);
        res.status(200).json(categories);
    } catch (error) {
        console.error("Erro ao buscar categorias:", error);
        res.status(500).json({ error: 'Erro ao carregar categorias.' });
    }
};

// 2. OBTER PERGUNTAS (O coração do App)
const getQuizzes = async (req, res) => {
    const { category, level, limit = 10 } = req.query;
    const language = req.headers['accept-language'] || 'pt-br';

    const userId = req.user.user_id || req.user.userId;

    try {
        let query = `
            SELECT * FROM quizzes 
            WHERE quiz_language = $1 
            AND quiz_id NOT IN (
                SELECT quiz_id FROM history WHERE user_id = $2
            )
        `;
        
        let values = [language, userId];
        let count = 3;

        if (category) {
            query += ` AND quiz_category = $${count}`;
            values.push(category);
            count++;
        }

        if (level) {
            query += ` AND quiz_level = $${count}`;
            values.push(level);
            count++;
        }

        // Ordena aleatoriamente e limita a quantidade
        query += ` ORDER BY RANDOM() LIMIT $${count}`;
        values.push(limit);

        const result = await pool.query(query, values);
        
        res.status(200).json(result.rows);

    } catch (error) {
        console.error("Erro ao buscar quizzes:", error);
        res.status(500).json({ error: 'Erro ao carregar as perguntas.' });
    }
};

// 3. SALVAR HISTÓRICO (Fim da partida)
const saveQuizHistory = async (req, res) => {
    const userId = req.user.userId; 
    
    const { quizId, startTime, endTime, quantResp, quantCorrect, score } = req.body;

    try {
        const result = await pool.query(
            `INSERT INTO history 
            (user_id, quiz_id, start_time, end_time, quant_resp, quant_correct, score) 
            VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
            [userId, quizId, startTime, endTime, quantResp, quantCorrect, score]
        );

        await pool.query(
            'UPDATE users SET user_score = user_score + $1 WHERE user_id = $2',
            [score, userId]
        );

        const user = await pool.query('SELECT * FROM users WHERE user_id = $1', [userId]);

        res.status(201).json({ message: 'Histórico salvo com sucesso!', user_score: user.rows[0].user_score, history: result.rows[0] });
    } catch (error) {
        console.error("Erro ao salvar histórico:", error);
        res.status(500).json({ error: 'Erro ao registrar pontuação.' });
    }
};

// 4. OBTER HISTÓRICO DO USUÁRIO
const getQuizHistory = async (req, res) => {
    const userId = req.user.userId;

    try {
        const query = `
            SELECT h.*, q.quiz_category, q.quiz_level 
            FROM history h
            LEFT JOIN quizzes q ON h.quiz_id = q.quiz_id
            WHERE h.user_id = $1
            ORDER BY h.start_time DESC
        `;
        const result = await pool.query(query, [userId]);
        
        res.status(200).json(result.rows);
    } catch (error) {
        console.error("Erro ao buscar histórico:", error);
        res.status(500).json({ error: 'Erro ao carregar histórico.' });
    }
};

// 5. CRIAR NOVA PERGUNTA (Opcional - Painel Admin)
const createQuiz = async (req, res) => {
    const { level, category, language, question, option1, option2, option3, answer } = req.body;

    try {
        const result = await pool.query(
            `INSERT INTO quizzes 
            (quiz_level, quiz_category, quiz_language, quiz_question, quiz_option_I, quiz_option_II, quiz_option_III, quiz_answer) 
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
            [level, category, language, question, option1, option2, option3, answer]
        );
        res.status(201).json(result.rows[0]);
    } catch (error) {
        console.error("Erro ao criar quiz:", error);
        res.status(500).json({ error: 'Erro ao inserir pergunta.' });
    }
};

module.exports = { getCategories, getQuizzes, saveQuizHistory, getQuizHistory, createQuiz };