FROM elixir:alpine as build

# install build dependencies
RUN apk add --no-cache git build-base nodejs npm yarn python3

RUN mkdir /app
WORKDIR /app
ARG MIX_ENV
# install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# build assets
COPY assets assets
RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
# at this point we should copy the rel directory but
# we are not using it so we can omit it
# COPY rel rel
RUN MIX_ENV=$MIX_ENV mix release

# prepare release image
FROM alpine:latest AS app

# install runtime dependencies
RUN apk add --no-cache bash openssl postgresql-client

EXPOSE 4000
ARG MIX_ENV

# prepare app directory
RUN mkdir /app
WORKDIR /app

# copy release to app container
COPY --from=build /app/_build/$MIX_ENV/rel/kamaitachi .
COPY entrypoint.sh .
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
CMD ["bash", "/app/entrypoint.sh"]
