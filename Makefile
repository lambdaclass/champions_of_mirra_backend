.PHONY: format check

format:
	mix format

check:
	mix credo --strict

.PHONY: setup dependencies db stop start run tests elixir-tests shell prepush credo docs

setup: dependencies
	mix deps.compile
	mix setup

dependencies:
	mix deps.get

db:
	docker compose up -d

stop:
	docker compose down

start: db dependencies run

run:
	mix assets.build
	iex -S mix phx.server

tests: elixir-tests

elixir-tests:
	mix test

shell:
	iex -S mix run --no-start --no-halt

prepush: format credo tests

credo:
	mix credo --strict
