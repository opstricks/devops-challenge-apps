FROM node:latest

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY .  .

ARG API_PORT
ARG API_DB

ENV PORT=$API_PORT
ENV DB=$API_DB

EXPOSE $PORT

CMD ["npm", "start"]
