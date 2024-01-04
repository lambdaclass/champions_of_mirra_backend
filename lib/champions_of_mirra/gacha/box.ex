defmodule ChampionsOfMirra.Gacha.Box do
  @moduledoc """
  Boxes are opened by users in order to obtain units.
  They have combinations of characters and drop rates, as well as an unique name.

  The way drop rates work is that each character on the pool has a "weight" that impacts how likely
  they are to be returned. This way we avoid messing with percentages if we don't want to. For example,
  if we wanted 4 characters in our pool, with the same odds of dropping, we can set 1 as the weight for each.
  If we still wanted to operate in terms of percentages, we can simply set 25 as the weight instead.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ChampionsOfMirra.Characters.Character
  alias ChampionsOfMirra.Gacha.CharacterDropRate

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "boxes" do
    field(:name, :string)
    field(:description, :string)

    has_many(:character_drop_rates, CharacterDropRate)
    many_to_many(:characters, Character, join_through: CharacterDropRate)

    timestamps()
  end

  @doc false
  def changeset(character, attrs),
    do:
      character
      |> cast(attrs, [:name, :description])
      |> cast_assoc(:character_drop_rates)
      |> validate_required([:name])
end
