FROM node:10-alpine
WORKDIR /home/root
COPY . .
RUN npm install
RUN npm install sequelize-cli -g
RUN npx sequelize db:migrate
EXPOSE 5000
CMD ["npm", "start"]
