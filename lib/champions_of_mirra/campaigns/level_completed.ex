defmodule ChampionsOfMirra.Campaigns.LevelCompleted do
  @moduledoc """
  The user-level association intermediate table.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ChampionsOfMirra.Accounts.User
  alias ChampionsOfMirra.Campaigns.Level

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "level_completed" do
    belongs_to(:user, User)
    belongs_to(:level, Level)

    timestamps()
  end

  @doc false
  def changeset(level_completed, attrs) do
    level_completed
    |> cast(attrs, [:user_id, :level_id])
    |> validate_required([:user_id, :level_id])
  end
end
