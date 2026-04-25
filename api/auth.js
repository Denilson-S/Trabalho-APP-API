const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const { OAuth2Client } = require('google-auth-library');
const pool = require('./db/db');

// Inicializa o cliente do Google com o seu Client ID do .env
const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

// --- Funções Auxiliares (Ajudam a não repetir código) ---
const generateAccessToken = (user) => {
    return jwt.sign({ userId: user.user_id, email: user.user_email }, process.env.JWT_SECRET, { expiresIn: '5m' });
};

const generateRefreshToken = (user) => {
    return jwt.sign({ userId: user.user_id }, process.env.REFRESH_JWT_SECRET, { expiresIn: '24h' });
};

// 1. LOGIN
const login = async (req, res) => {
    const { email, password } = req.body;

    try {
        const result = await pool.query('SELECT * FROM users WHERE user_email = $1', [email]);
        const user = result.rows[0];
        
        if (!user || !(await bcrypt.compare(password, user.user_password))) {
            return res.status(401).json({ error: 'Email ou senha incorretos.' });
        }

        const accessToken = generateAccessToken(user);
        const refreshToken = generateRefreshToken(user);

        await pool.query('UPDATE users SET user_refresh_token = $1 WHERE user_id = $2', [refreshToken, user.user_id]);

        res.status(200).json({ 
            accessToken, 
            refreshToken, 
            user: { name: user.user_name, email: user.user_email, score: user.user_score } 
        });
    } catch (error) {
        res.status(500).json({ error: `Erro ao realizar login. ${error.message}` });
    }
};

// 2. REGISTER
const register = async (req, res) => {
    const { name, email, password } = req.body;

    const existingUser = await pool.query('SELECT * FROM users WHERE user_email = $1', [email]);
    if (existingUser.rows.length > 0) {
        return res.status(400).json({ error: 'Usuário já existe.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = await pool.query(
        'INSERT INTO users (user_name, user_email, user_password) VALUES ($1, $2, $3) RETURNING *',
        [name, email, hashedPassword]
    );

    const accessToken = generateAccessToken(newUser.rows[0]);
    const refreshToken = generateRefreshToken(newUser.rows[0]);

    await pool.query('UPDATE users SET user_refresh_token = $1 WHERE user_id = $2', [refreshToken, newUser.rows[0].id]);

    res.status(201).json({
        accessToken,
        refreshToken,
        user: { name: newUser.rows[0].user_name, email: newUser.rows[0].user_email, score: newUser.rows[0].user_score }
    });
};

// 3. REFRESH TOKEN
const refresh = async (req, res) => {
    const { refreshToken } = req.body;

    if (!refreshToken) {
        return res.status(401).json({ error: 'Refresh Token não fornecido.' });
    }

    try {
        const decoded = jwt.verify(refreshToken, process.env.REFRESH_JWT_SECRET);

        const result = await pool.query('SELECT * FROM users WHERE user_id = $1', [decoded.userId]);
        const user = result.rows[0];

        if (!user || user.user_refresh_token !== refreshToken) {
            return res.status(403).json({ error: 'Refresh Token inválido ou revogado. Faça login novamente.' });
        }

        const newAccessToken = generateAccessToken(user);
        const newRefreshToken = generateRefreshToken(user);

        await pool.query('UPDATE users SET user_refresh_token = $1 WHERE user_id = $2', [newRefreshToken, user.user_id]);

        res.status(200).json({ 
            accessToken: newAccessToken, 
            refreshToken: newRefreshToken 
        });

    } catch (error) {
        return res.status(403).json({ error: 'Refresh Token expirado. Faça login novamente.' });
    }
};

// 4. LOGIN COM GOOGLE (NOVO)
const googleLogin = async (req, res) => {
    const { idToken } = req.body;

    if (!idToken) {
        return res.status(400).json({ error: 'Token do Google não fornecido.' });
    }

    try {
        const ticket = await googleClient.verifyIdToken({
            idToken: idToken,
            audience: process.env.GOOGLE_CLIENT_ID,
        });

        const payload = ticket.getPayload();
        const email = payload.email;
        const name = payload.name;

        let result = await pool.query('SELECT * FROM users WHERE user_email = $1', [email]);
        let user = result.rows[0];

        if (!user) {
            const randomPassword = crypto.randomBytes(16).toString('hex');
            const hashedPassword = await bcrypt.hash(randomPassword, 10);

            const insertResult = await pool.query(
                'INSERT INTO users (user_name, user_email, user_password) VALUES ($1, $2, $3) RETURNING *',
                [name, email, hashedPassword]
            );
            user = insertResult.rows[0];
        }

        const accessToken = generateAccessToken(user);
        const refreshToken = generateRefreshToken(user);

        await pool.query('UPDATE users SET user_refresh_token = $1 WHERE user_id = $2', [refreshToken, user.user_id]);

        res.status(200).json({ 
            accessToken, 
            refreshToken, 
            user: { name: user.user_name, email: user.user_email } 
        });

    } catch (error) {
        console.error("Erro no Google Login:", error);
        res.status(401).json({ error: 'Token do Google inválido ou expirado.' });
    }
};

// 5. LOGOUT (Revoga o Refresh Token)
const logout = async (req, res) => {
    const { userId } = req.user.userId;
    try {
        await pool.query('UPDATE users SET user_refresh_token = NULL WHERE user_id = $1', [userId]);
        res.status(200).json({ message: 'Logout realizado com sucesso.' });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao fazer logout.' });
    }
};

module.exports = { login, register, refresh, googleLogin, logout };