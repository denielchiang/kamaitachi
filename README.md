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

### Linting
[Credo](https://hexdocs.pm/credo/overview.html) - A static code analysis tool for the Elixir language with a focus on teaching and code consistency.

  * Run `mix check.linter` to check if suggestion make sense to you or not

### Security check

[Sobelow](https://hexdocs.pm/sobelow/readme.html#content) - A security-focused static analysis tool for the Phoenix framework. For security researchers, it is a useful tool for getting a quick view of points-of-interest. For project maintainers, it can be used to prevent the introduction of a number of common vulnerabilities.

  * Run ` mix check.code.security` with presetting configuration that come [from here](https://elixirforum.com/t/working-content-security-policy-for-phoenix-channels/11443)

### Compile
[Mix compile](https://hexdocs.pm/mix/Mix.Tasks.Compile.Elixir.html#module-command-line-options) - This part can be adjusted if need, preset to **treats warnings in the current project as errors and return a non-zero exit code** first

  * Run `mix compile` with preset compiler option

### Format
[Mix format](https://hexdocs.pm/mix/master/Mix.Tasks.Format.html#module-task-specific-options) - Preset options with dry-run and check-format as presetting

  * Run `mix check.code.format` for checking format by dry-run

### Test coverage
[ExConveralls](https://github.com/parroty/excoveralls) - CLI Tools for calculating test case coverage

  * Run `mix check.code.coverage` to get coverage reporting in CLI

### To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`
  * Open the [GraphiQL Interface](http://localhost:4000/v1/graphiql) and import [this workspace](https://gist.github.com/ccf67b0cd54f7b528f179e4f1fe2b1dd.git)
  * Run the `mutation - accountsLogin`
  * Run the `query - accountsMe` and copy the token returned
  * Change the ws url token on `subscription - accountsUserCount` and run the query
  * Verify `accountsUserCount` value changing every 10 seconds on the result panel

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Deploy


Using Digital Ocean or other VPS that provide Ubuntu 18.04TLS with __root__.

- Genereate ssh key for GitHub and copy publish key and paste into github settins -> deploy key added

        ssh-keygen -t rsa -b 4096 -C "{email}"
        cat .ssh/id_ras.pub

- Clone source code
        
        # Enter project source folder
        cd ~/opt

        # Download source code
        git clone git@github.com:denielchiang/kamaitachi.git

- Install Postgres

  Using Managed Database

- Install dep libs

        # Install deps
        ./bin/build_env.sh

- Build release

        # build release
        ./bin/build.sh

- Nginx settings

        # Install Nginx
        apt-get -qq install nginx
        # Copy paste bin/nginx.conf settings
        cp bin/nginx.conf /etc/nginx/conf.d/kamaitachi.conf

- Run start
        
        # Remote start server
        ssh root@kamaitachi_server '~/opt/kamaitachi/_build/prod/rel/kamaitachi/bin/kamaitachi start'

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
