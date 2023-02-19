FROM node:17
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN mkdir erica
EXPOSE 3000
ENTRYPOINT ["node"]
CMD [ "app.js" ]
