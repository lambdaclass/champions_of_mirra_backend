defmodule ChampionsOfMirra.Characters.Character do
  @moduledoc """
  Characters are the template on which players are based.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "characters" do
    field(:name, :string)
    timestamps()
  end

  @doc false
  def changeset(character, attrs),
    do:
      character
      |> cast(attrs, [:name])
      |> validate_required([:name])
end
