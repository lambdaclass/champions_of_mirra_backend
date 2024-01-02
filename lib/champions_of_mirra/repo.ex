defmodule ChampionsOfMirra.Repo do
  use Ecto.Repo,
    otp_app: :champions_of_mirra,
    adapter: Ecto.Adapters.Postgres
end
