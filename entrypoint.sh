#!/bin/bash
# docker entrypoint script.

# wait until Postgres is ready
while ! pg_isready -q -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

echo "Database is ready..."

bin="/app/bin/kamaitachi"
eval "$bin eval \"Kamaitachi.Release.migrate\""

# start the elixir application
exec "$bin" "start"
