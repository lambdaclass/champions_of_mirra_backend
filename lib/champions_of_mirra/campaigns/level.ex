defmodule ChampionsOfMirra.Campaigns.Level do
  @moduledoc """
  Characters are the template on which players are based.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ChampionsOfMirra.Campaigns.Campaign
  alias ChampionsOfMirra.Units.Unit

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "levels" do
    field(:name, :string)
    field(:number, :integer)

    belongs_to(:campaign, Campaign)

    has_many(:units, Unit, foreign_key: :campaign_level_id)

    timestamps()
  end

  @doc false
  def changeset(character, attrs),
    do:
      character
      |> cast(attrs, [:name, :number, :campaign_id])
      |> cast_assoc(:units)
      |> validate_required([:name, :number])
end
