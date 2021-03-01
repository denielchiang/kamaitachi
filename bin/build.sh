#!/usr/bin/env bash
# exit on error
set -o errexit

read -p "Enter Database URL: " database_url
export DATABASE_URL=$database_url
export SECRET_KEY_BASE=`mix phx.gen.secret`

echo "==> Running build task"

echo "===> Installing Hex and Rebar"
mix local.hex --force
mix local.rebar --force

# Initial setup
mix local.hex --force
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite
source ./bin/build.sh
