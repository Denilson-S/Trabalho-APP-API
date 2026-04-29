# Quiz Master - Projeto Mobile

O **Quiz Master** é um aplicativo mobile desenvolvido em Flutter que oferece uma experiência de quiz completa e gamificada. Os usuários podem testar seus conhecimentos em diversas categorias, como Ciência, História, Esportes e Cinema, escolhendo entre diferentes níveis de dificuldade.

## 🚀 Tecnologias Utilizadas

### Mobile (Frontend)
- **Flutter & Dart:** Framework principal para desenvolvimento cross-platform.
- **Provider:** Gerenciamento de estado de forma reativa.
- **Dio:** Cliente HTTP para comunicação robusta com a API.
- **Isar:** Banco de dados local NoSQL de alta performance para persistência de dados.
- **Flutter Secure Storage:** Armazenamento seguro de tokens de autenticação (JWT).
- **Google Fonts & Lucide Icons:** Identidade visual e ícones modernos.
- **Google Sign-In:** Integração para autenticação social.

### Backend (API)
- **Node.js & Express:** Framework para a construção da API REST.
- **PostgreSQL:** Banco de dados relacional para armazenamento de usuários, perguntas e histórico.
- **JWT (JSON Web Tokens):** Sistema de autenticação seguro com access e refresh tokens.
- **Docker & Docker Compose:** Containerização para facilitar o ambiente de desenvolvimento e deploy.
- **Gemini AI:** Integração com inteligência artificial para geração ou processamento de conteúdo.

---

## 🛠️ Como Rodar a API

A API e o banco de dados estão configurados para rodar via **Docker**, o que simplifica o processo de configuração.

### Pré-requisitos
- Docker e Docker Compose instalados.
- Arquivo `.env` configurado na raiz do projeto (utilize o modelo abaixo).

### Passos para execução
1. **Configurar o ambiente:**
   Certifique-se de que o arquivo `.env` na raiz do projeto contém as credenciais corretas, especialmente o `API_URL` (ajuste para o IP da sua máquina local para que o emulador/celular consiga acessar).

2. **Subir os containers:**
   No terminal, na raiz do projeto, execute:
   ```bash
   docker-compose up --build
   ```

3. **Verificação:**
   - A API estará disponível em `http://localhost:5000` (ou a porta definida no seu `.env`).
   - O banco de dados PostgreSQL será iniciado e os scripts de schema e dados iniciais (`api/db/db_schema.sql` e `api/db/db_data.sql`) serão executados automaticamente na primeira inicialização.

---

## 📝 Configuração do Ambiente (.env)

Crie um arquivo `.env` na raiz com o seguinte conteúdo:

```env
# Database
DB_HOST=quizz_db
DB_PORT=5432
DB_USER=admin
DB_PASSWORD=adminpassword
DB_NAME=quizz_api_db

# API
API_PORT=5000
TZ=UTC
JWT_SECRET=sua_chave_secreta_aqui
REFRESH_JWT_SECRET=outra_chave_secreta_aqui

# Google Auth
GOOGLE_CLIENT_ID=seu_client_id_google
GOOGLE_CLIENT_SECRET=seu_client_secret_google

# App Connection
API_URL=http://SEU_IP_LOCAL:5000/api

# AI Integration
GEMINI_API_KEY=sua_chave_gemini
```
