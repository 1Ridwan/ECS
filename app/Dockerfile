FROM node:20-alpine

WORKDIR /app
COPY . ./

RUN npm ci && npm run build

# create data dir (and make it writable if you switch to the node user)
RUN mkdir -p /app/data && chown -R node:node /app

ENV NODE_ENV=production
EXPOSE 3001

# (optional) run as non-root for better security
USER node

CMD ["node", "server/server.js"]
