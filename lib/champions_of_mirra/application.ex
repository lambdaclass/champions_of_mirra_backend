defmodule ChampionsOfMirra.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChampionsOfMirraWeb.Telemetry,
      ChampionsOfMirra.Repo,
      {DNSCluster, query: Application.get_env(:champions_of_mirra, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChampionsOfMirra.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ChampionsOfMirra.Finch},
      # Start a worker by calling: ChampionsOfMirra.Worker.start_link(arg)
      # {ChampionsOfMirra.Worker, arg},
      # Start to serve requests, typically the last entry
      ChampionsOfMirraWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChampionsOfMirra.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChampionsOfMirraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
