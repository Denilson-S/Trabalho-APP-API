# Usamos a versão 20 (atual) na variante 'alpine', que é super leve e rápida
FROM node:20-alpine

# Define a pasta de trabalho
WORKDIR /usr/src/app

# Copia os arquivos de dependência
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante do código da sua API para dentro do contêiner
COPY . .

# Expõe a porta
EXPOSE 5000

# Inicia a aplicação apontando para o arquivo correto!
CMD ["node", "index.js"]