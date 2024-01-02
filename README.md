# Lambda Game Backend
Open source backend developed by LambdaClass in Elixir, for the communication, and Rust, for the state management.

## Table of Contents

- [Lambda Game Backend](#lambda-game-backend)
  - [Table of Contents](#table-of-contents)
  - [Running the Backend](#running-the-backend)
    - [Requirements](#requirements)
  - [About the temporary backend](#about-the-temporary-backend)


## Running the Backend

### Requirements

- Erlang OTP >= 26
- Elixir >= 1.15.4
- Docker and docker compose
- [inotify-utils](https://hexdocs.pm/phoenix/installation.html#inotify-tools-for-linux-users) if using Linux (optional, for development live reload)

Ensure Docker is running and execute:

```bash
git clone https://github.com/lambdaclass/champions_of_mirra_backend
make db
make setup
make start
```

Whenever you make changes to the game's `config.json`, you will need to run this so that they get reflected:

```elixir
DarkWorldsServer.Utils.Config.clean_import()
```

## About the temporary backend

This app is essentially a "lite" version of the backend that ignores all of the stuff related to Curse of Mirra's mechanics (all rust code is gone!). Also the config json is gone. Instead, we will handle character configs in our seeds.

What was kept:
- Accounts
- Characters (but only their "name" field)
- Units
- Autobattles
- User & Autobattle endpoints
