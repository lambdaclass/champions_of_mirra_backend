defmodule ChampionsOfMirra.Gacha.CharacterDropRate do
  @moduledoc """
  The character-box association intermediate table.

  Holds a required `weight` value that defines the drop rate. See Box moduledoc for details.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ChampionsOfMirra.Characters.Character
  alias ChampionsOfMirra.Gacha.Box

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "character_drop_rates" do
    belongs_to(:box, Box)
    belongs_to(:character, Character)
    field(:weight, :integer)

    timestamps()
  end

  @doc false
  def changeset(level_completed, attrs) do
    level_completed
    |> cast(attrs, [:box_id, :character_id, :weight])
    |> validate_required([:character_id, :weight])
  end
end
