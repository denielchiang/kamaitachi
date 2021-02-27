#!/usr/bin/env bash
# exit on error
set -o errexit

export SECRET_KEY_BASE=`mix phx.gen.secret`
read -p "Enter Database URL: "  database_url
export DATABASE_URL=$database_url

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod mix run priv/repo/seeds.exs
