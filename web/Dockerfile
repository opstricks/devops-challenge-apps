FROM node:latest

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ARG WEB_PORT
ARG API_HOST

ENV PORT=$WEB_PORT
ENV API_HOST=$API_HOST

EXPOSE $PORT

CMD [ "npm", "start" ]
