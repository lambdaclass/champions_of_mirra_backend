# Lambda Game Backend
Open source backend developed by LambdaClass in Elixir, for the communication, and Rust, for the state management.

## Table of Contents

- [Lambda Game Backend](#lambda-game-backend)
  - [Table of Contents](#table-of-contents)
  - [Running the Backend](#running-the-backend)
    - [Requirements](#requirements)
  - [Contributing](#contributing)


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

## Contributing
