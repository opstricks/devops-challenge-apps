FROM node:latest

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ENV PORT=5000
ENV API_HOST=http://api:6000

EXPOSE 5000

CMD [ "npm", "start" ]

# FROM node:9-slim
# ENV PORT 8080
# EXPOSE 8080
# WORKDIR /usr/src/app
# COPY . .
# CMD ["npm", "start"]