# ---------- build stage ----------
FROM node:20-alpine AS build
WORKDIR /app

# Install deps
COPY . .
RUN npm ci
RUN npm run build

# ---------- runtime stage ----------
FROM alpine:3.20

# Install Node, Nginx, dumb-init
RUN apk add --no-cache nodejs npm nginx dumb-init

WORKDIR /app

# Copy app from build stage
COPY --from=build /app /app

# Create writable dirs for nginx + app data
RUN mkdir -p /app/data \
    /run/nginx \
    /tmp/nginx/client_temp /tmp/nginx/proxy_temp /tmp/nginx/fastcgi_temp \
    /tmp/nginx/uwsgi_temp /tmp/nginx/scgi_temp \
 && chmod -R 755 /app /run/nginx /tmp/nginx

# Copy Nginx config and start script
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV NODE_ENV=production
EXPOSE 80

# Run under dumb-init to forward signals properly
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]
