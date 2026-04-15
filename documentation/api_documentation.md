# Documentação da API - Quizz App

Esta API fornece o backend para o aplicativo Quizz App, gerenciando autenticação, perguntas e histórico de pontuação.

## 🚀 Tecnologias Utilizadas

- **Runtime:** Node.js
- **Framework:** Express.js
- **Banco de Dados:** PostgreSQL
- **Autenticação:** JWT (JSON Web Tokens) e Google OAuth 2.0
- **Criptografia:** Bcrypt.js
- **AI Integrada:** Google Generative AI (Gemini) para geração de perguntas (scripts de seed).

---

## 🔐 Autenticação

A maioria dos endpoints requer um token JWT enviado no cabeçalho `Authorization` como um `Bearer Token`.

### 1. Registro de Usuário
**Endpoint:** `POST /api/auth/register`
- **Corpo da Requisição:**
  ```json
  {
    "name": "Nome do Usuário",
    "email": "usuario@exemplo.com",
    "password": "senha_segura"
  }
  ```
- **Resposta (201):**
  ```json
  {
    "accessToken": "...",
    "refreshToken": "...",
    "user": { "name": "...", "email": "..." }
  }
  ```

### 2. Login
**Endpoint:** `POST /api/auth/login`
- **Corpo da Requisição:**
  ```json
  {
    "email": "usuario@exemplo.com",
    "password": "senha_segura"
  }
  ```
- **Resposta (200):**
  ```json
  {
    "accessToken": "...",
    "refreshToken": "...",
    "user": { "name": "...", "email": "..." }
  }
  ```

### 3. Atualizar Token (Refresh)
**Endpoint:** `POST /api/auth/refresh`
- **Corpo da Requisição:**
  ```json
  {
    "refreshToken": "..."
  }
  ```
- **Resposta (200):**
  ```json
  {
    "accessToken": "...",
    "refreshToken": "..."
  }
  ```

### 4. Login com Google
**Endpoint:** `POST /api/auth/google`
- **Corpo da Requisição:**
  ```json
  {
    "idToken": "TOKEN_DO_GOOGLE_OAUTH"
  }
  ```
- **Resposta (200):** Semelhante ao login padrão.

### 5. Logout
**Endpoint:** `POST /api/auth/logout`
- **Cabeçalho:** `Authorization: Bearer <accessToken>`
- **Resposta (200):**
  ```json
  { "message": "Logout realizado com sucesso." }
  ```

---

## 🧩 Quizzes (Perguntas)

### 1. Listar Categorias
**Endpoint:** `GET /api/categories`
- **Cabeçalho:** `Authorization: Bearer <accessToken>`
- **Resposta (200):** `["Ciência", "História", "Tecnologia", ...]`

### 2. Buscar Perguntas
**Endpoint:** `GET /api/quizzes`
- **Cabeçalho:** `Authorization: Bearer <accessToken>`
- **Parâmetros de Consulta (Opcionais):**
  - `category`: Filtrar por categoria.
  - `level`: Filtrar por dificuldade (ex: Fácil, Médio, Difícil).
  - `limit`: Quantidade de perguntas (Padrão: 10).
- **Cabeçalho Adicional (Opcional):** `accept-language` (Padrão: `pt-br`).
- **Resposta (200):**
  ```json
  [
    {
      "quiz_id": 1,
      "quiz_level": "Fácil",
      "quiz_category": "Geral",
      "quiz_language": "pt-br",
      "quiz_question": "Qual a capital do Brasil?",
      "quiz_option_i": "Rio de Janeiro",
      "quiz_option_ii": "São Paulo",
      "quiz_option_iii": "Brasília",
      "quiz_answer": "Brasília"
    }
  ]
  ```

### 3. Criar Pergunta (Admin)
**Endpoint:** `POST /api/quizzes`
- **Cabeçalho:** `Authorization: Bearer <accessToken>`
- **Corpo da Requisição:**
  ```json
  {
    "level": "Difícil",
    "category": "Matemática",
    "language": "pt-br",
    "question": "Pergunta aqui?",
    "option1": "Opção A",
    "option2": "Opção B",
    "option3": "Opção C",
    "answer": "Opção B"
  }
  ```

---

## 📜 Histórico e Pontuação

### 1. Salvar Resultado de Partida
**Endpoint:** `POST /api/history`
- **Cabeçalho:** `Authorization: Bearer <accessToken>`
- **Corpo da Requisição:**
  ```json
  {
    "quizId": 1,
    "startTime": "2023-10-27T10:00:00Z",
    "endTime": "2023-10-27T10:05:00Z",
    "quantResp": 1,
    "quantCorrect": 1,
    "score": 100
  }
  ```
- **Resposta (201):** Confirmação da gravação e atualização da pontuação do usuário.

### 2. Obter Histórico do Usuário
**Endpoint:** `GET /api/history`
- **Cabeçalho:** `Authorization: Bearer <accessToken>`
- **Resposta (200):** Lista de partidas anteriores com detalhes de data, pontuação e categoria.

---

## 🗄️ Estrutura do Banco de Dados

### Tabela `users`
| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `user_id` | SERIAL | Chave Primária |
| `user_name` | VARCHAR | Nome do usuário |
| `user_email` | VARCHAR | Email único |
| `user_password` | VARCHAR | Senha (Hashed) |
| `user_refresh_token` | VARCHAR | Token para renovação de sessão |
| `user_score` | INT | Pontuação total acumulada |

### Tabela `quizzes`
| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `quiz_id` | SERIAL | Chave Primária |
| `quiz_level` | VARCHAR | Dificuldade |
| `quiz_category` | VARCHAR | Categoria |
| `quiz_language` | VARCHAR | Idioma da pergunta |
| `quiz_question` | VARCHAR | O enunciado da pergunta |
| `quiz_option_I` | VARCHAR | Opção 1 |
| `quiz_option_II` | VARCHAR | Opção 2 |
| `quiz_option_III` | VARCHAR | Opção 3 |
| `quiz_answer` | VARCHAR | Resposta correta (deve ser uma das opções) |

### Tabela `history`
| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `history_id` | SERIAL | Chave Primária |
| `user_id` | INT | FK para `users` |
| `quiz_id` | INT | FK para `quizzes` |
| `start_time` | TIMESTAMP | Início da partida |
| `end_time` | TIMESTAMP | Fim da partida |
| `quant_resp` | INT | Questões respondidas |
| `quant_correct` | INT | Questões acertadas |
| `score` | INT | Pontos ganhos na partida |

---

## 🛠️ Configuração de Ambiente (`.env`)

A API espera as seguintes variáveis de ambiente:

```env
PORT=5000
DB_HOST=...
DB_PORT=5432
DB_USER=...
DB_PASSWORD=...
DB_NAME=...
JWT_SECRET=...
REFRESH_JWT_SECRET=...
GOOGLE_CLIENT_ID=...
GEMINI_API_KEY=...
```
