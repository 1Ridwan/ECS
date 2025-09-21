#!/bin/sh
set -e

# ensure data dir exists and is writable
mkdir -p /app/data
chmod 777 /app/data

# start node (background) then nginx in foreground
node /app/server/server.js &
NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx nginx -g 'daemon off;'
