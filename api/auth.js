const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('./db/db');

// --- Funções Auxiliares (Ajudam a não repetir código) ---
const generateAccessToken = (user) => {
    return jwt.sign({ userId: user.id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '5m' });
};

const generateRefreshToken = (user) => {
    return jwt.sign({ userId: user.id }, process.env.REFRESH_JWT_SECRET, { expiresIn: '24h' });
};

// ==========================================
// 1. LOGIN
// ==========================================
const login = async (req, res) => {
    const { email, password } = req.body;

    try {
        const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        const user = result.rows[0];

        if (!user || !(await bcrypt.compare(password, user.password))) {
            return res.status(401).json({ error: 'Email ou senha incorretos.' });
        }

        // 1. Gera os dois tokens
        const accessToken = generateAccessToken(user);
        const refreshToken = generateRefreshToken(user);

        // 2. Salva o Refresh Token no banco de dados
        await pool.query('UPDATE users SET refresh_token = $1 WHERE id = $2', [refreshToken, user.id]);

        // 3. Devolve ambos para o Flutter
        res.status(200).json({ 
            accessToken, 
            refreshToken, 
            user: { name: user.name, email: user.email } 
        });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao realizar login.' });
    }
};

// ==========================================
// 2. REFRESH TOKEN (A Mágica da Renovação)
// ==========================================
const refresh = async (req, res) => {
    // O Flutter vai mandar o refresh token antigo no corpo da requisição
    const { refreshToken } = req.body;

    if (!refreshToken) {
        return res.status(401).json({ error: 'Refresh Token não fornecido.' });
    }

    try {
        // 1. Verifica se o token é válido matematicamente e não expirou as 24h
        const decoded = jwt.verify(refreshToken, process.env.REFRESH_JWT_SECRET);

        // 2. Verifica no banco se este é realmente o token atual do usuário
        // Isso impede que um hacker use um refresh token velho que já foi rodado
        const result = await pool.query('SELECT * FROM users WHERE id = $1', [decoded.userId]);
        const user = result.rows[0];

        if (!user || user.refresh_token !== refreshToken) {
            return res.status(403).json({ error: 'Refresh Token inválido ou revogado. Faça login novamente.' });
        }

        // 3. Se tudo está ok, fazemos a ROTAÇÃO. 
        // Geramos um novo Access (mais 5 min) e um novo Refresh (mais 24h)
        const newAccessToken = generateAccessToken(user);
        const newRefreshToken = generateRefreshToken(user);

        // 4. Atualiza o banco com o novo Refresh Token
        await pool.query('UPDATE users SET refresh_token = $1 WHERE id = $2', [newRefreshToken, user.id]);

        // 5. Devolve os tokens novos
        res.status(200).json({ 
            accessToken: newAccessToken, 
            refreshToken: newRefreshToken 
        });

    } catch (error) {
        // Se cair aqui, é porque o jwt.verify falhou (ex: passou de 24h)
        return res.status(403).json({ error: 'Refresh Token expirado. Faça login novamente.' });
    }
};

// ==========================================
// 3. LOGOUT (Revoga o Token)
// ==========================================
const logout = async (req, res) => {
    const { userId } = req.body; // Num cenário real, você pega o ID do middleware de autenticação
    try {
        // Apaga o refresh token do banco. Agora, mesmo que o hacker tenha o token de 24h, 
        // ele vai bater na validação do banco (passo 2 do refresh) e ser barrado.
        await pool.query('UPDATE users SET refresh_token = NULL WHERE id = $1', [userId]);
        res.status(200).json({ message: 'Logout realizado com sucesso.' });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao fazer logout.' });
    }
};

module.exports = { login, refresh, logout }; // Não esqueça de exportar a função de registro também!