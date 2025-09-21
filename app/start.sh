#!/bin/sh
set -e

# Start Node app in background on 3001
node /app/server/server.js &

# Start Nginx in foreground
exec nginx -g 'daemon off;'
