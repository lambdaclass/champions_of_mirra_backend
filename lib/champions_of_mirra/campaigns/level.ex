defmodule ChampionsOfMirra.Campaigns.Level do
  @moduledoc """
  Levels belong to campaigns and are composed by a set of units. They have an unique name and an order that's unique by campaign.

  When users beat levels, it is tracked by the intermediate LevelCompleted table.
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
