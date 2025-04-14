FROM node:latest
WORKDIR /app
ENV NODE_ENV=production
COPY . .
RUN ["npm", "ci"]

RUN chmod +x entrypoint.sh

VOLUME /app/data
EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
CMD ["npm", "run", "start"]
