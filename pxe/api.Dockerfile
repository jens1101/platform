FROM node:23

WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json ./
COPY src ./src
RUN ["npm", "ci"]

VOLUME /app/data
EXPOSE 80

CMD ["npm", "run", "start"]
