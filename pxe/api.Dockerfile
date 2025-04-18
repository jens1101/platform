FROM node:23

WORKDIR /app
ENV NODE_ENV=production
# TODO: optimise this. Oftentimes a rebuild is triggerd from an irrevevant file change.
COPY . .
RUN ["npm", "ci"]

VOLUME /app/data
EXPOSE 80

CMD ["npm", "run", "start"]
