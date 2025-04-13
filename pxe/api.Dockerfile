FROM node:latest
WORKDIR /app
COPY . .
RUN ["npm", "ci"]
VOLUME /app/data
EXPOSE 80
CMD ["npm", "run", "start"]
