# Kamaitachi
A Livestreaming service tnat either provide livestreamer host their livestreaming by geographically or be a spectator watch livestreaming or history playback video.

## Infra
It will be an umbrella projects that provide GraphQL based WebSocket API that provide service for those clients:
* iOS
* Android
* Web

## Purpose
This project is made for verfied minimal concept. At very first testing, we have successed using [Mux API](https://mux.com/) and do livestreaming from iOS 14.4 and watching from Safari by using [HLS.js](https://github.com/video-dev/hls.js/).

Now we need to deploy to VPS and tyried to recreate the livestreaming for servral observations:
* Latency(Last time was average 20~30 secs as Mux doc said)
* Quality(Base on [Mux doc](https://docs.mux.com/docs/configure-broadcast-software), we have 1080p 30fps, 720p 30fps and 480p 30fps, but need to consider avalible bandwidth during uploading)
* Playback
* Price increment curve

## Development

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`
  * Open the [GraphiQL Interface](http://localhost:4000/v1/graphiql) and import [this workspace)(./doc/kamaitachi_test_data/subscription_ui_history.json)
  * Run the `mutation - accountsLogin`
  * Run the `query - accountsMe` and copy the token returned
  * Change the ws url token on `subscription - accountsUserCount` and run the query
  * Verify `accountsUserCount` value changing every 10 seconds on the result panel

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
