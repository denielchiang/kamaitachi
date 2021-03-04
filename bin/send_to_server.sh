#!/usr/bin/env bash
# exit on error
set -o errexit
SERVER_HOST=""

if [ $1 = "prod" ]; then
    SERVER_HOST="kamaitachi_server"
else
    SERVER_HOST="$1.kamaitachi_server"
fi

echo "sending docker env file..."
scp  ./config/docker.env root@$SERVER_HOST:~/etc/kamaitachi/config/docker.env
echo "sent"

echo "sending docker compose file..."
scp ./docker-compose.yml root@$SERVER_HOST:~/etc/kamaitachi/docker-compose.yml
echo "sent"
