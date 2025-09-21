FROM node:20-alpine

WORKDIR /app

COPY . ./

# install deps and build the web UI
RUN npm ci && npm run build

# run the server on port 3001
CMD ["node", "server/server.js"]

EXPOSE 3001