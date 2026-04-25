# Documentação da API - Quizz App

Esta API fornece o backend para o aplicativo Quizz Master, gerenciando autenticação, perguntas e persistência do histórico de partidas.

## 🚀 Tecnologias Utilizadas

- **Runtime:** Node.js (v20-alpine)
- **Framework:** Express.js
- **Banco de Dados:** PostgreSQL
- **Autenticação:** JWT (Access Token de 5m e Refresh Token de 24h) e Google OAuth 2.0
- **Criptografia:** Bcryptjs
- **AI Integrada:** Google Generative AI (Gemini) utilizada em scripts de seed para geração de carga de dados.

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
    "user": { "name": "...", "email": "...", "score": 0 }
  }
  ```

### 2. Login Tradicional
**Endpoint:** `POST /api/auth/login`
- **Corpo da Requisição:**
  ```json
  {
    "email": "usuario@exemplo.com",
    "password": "senha_segura"
  }
  ```
- **Resposta (200):** Semelhante ao registro.

### 3. Login com Google
**Endpoint:** `POST /api/auth/google`
- **Corpo da Requisição:** `{ "idToken": "..." }`
- **Nota:** Cria o usuário automaticamente se ele não existir no banco.

### 4. Atualizar Token (Refresh)
**Endpoint:** `POST /api/auth/refresh`
- **Corpo da Requisição:** `{ "refreshToken": "..." }`
- **Resposta (200):** Retorna um novo par de `accessToken` e `refreshToken`.

### 5. Logout
**Endpoint:** `POST /api/auth/logout`
- **Ação:** Remove o `user_refresh_token` do banco de dados, invalidando a sessão.

---

## 🧩 Quizzes (Perguntas)

### 1. Listar Categorias
**Endpoint:** `GET /api/categories`
- **Resposta (200):** `["Cinema", "Geography", "History", ...]`

### 2. Buscar Perguntas
**Endpoint:** `GET /api/quizzes`
- **Parâmetros de Consulta (Opcionais):**
  - `category`: Filtrar por categoria.
  - `level`: 'Easy', 'Medium' ou 'Hard'.
  - `limit`: Quantidade de perguntas (Padrão: 10).
- **Cabeçalho:** `accept-language` (Padrão: `pt-br`) para definir o idioma das perguntas.
- **Lógica:** Retorna perguntas aleatórias que o usuário ainda **não respondeu**.

### 3. Criar Pergunta (Admin)
**Endpoint:** `POST /api/quizzes`
- **Corpo da Requisição:**
  ```json
  {
    "level": "Hard",
    "category": "Cinema",
    "language": "pt-br",
    "question": "Pergunta?",
    "option1": "Incorreta 1",
    "option2": "Incorreta 2",
    "option3": "Incorreta 3",
    "answer": "Correta"
  }
  ```

---

## 📜 Histórico e Pontuação

### 1. Salvar Resultado de Partida (Lote)
**Endpoint:** `POST /api/history`
- **Corpo da Requisição:** Um array de registros de cada pergunta respondida:
  ```json
  [
    {
      "quizId": 1,
      "startTime": "2026-04-22T10:00:00Z",
      "endTime": "2026-04-22T10:00:10Z",
      "score": 10
    }
  ]
  ```
- **Lógica:** Salva cada registro e incrementa o `user_score` total do usuário.

### 2. Obter Histórico do Usuário
**Endpoint:** `GET /api/history`
- **Resposta (200):** Uma lista de listas, onde cada sub-lista representa uma partida (agrupada por horário de início).

---

## 🗄️ Estrutura do Banco de Dados

### Tabela `users`
| Coluna | Descrição |
| :--- | :--- |
| `user_id` | Chave Primária. |
| `user_name` | Nome do usuário. |
| `user_email` | Email único. |
| `user_password` | Hash da senha. |
| `user_score` | Pontuação total acumulada. |

### Tabela `quizzes`
| Coluna | Descrição |
| :--- | :--- |
| `quiz_level` | Easy, Medium ou Hard. |
| `quiz_category` | Categoria da pergunta. |
| `quiz_language` | Idioma (pt-br, en-us, es-es). |
| `quiz_option_I/II/III` | Opções incorretas. |
| `quiz_answer` | Opção correta. |

### Tabela `history`
| Coluna | Descrição |
| :--- | :--- |
| `user_id` | FK para o usuário. |
| `quiz_id` | FK para a pergunta. |
| `score` | Pontos obtidos na resposta. |

---

## 🛠️ Configuração de Ambiente (`.env`)
```env
PORT=5000
TZ=UTC
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
