defmodule ChampionsOfMirra.Campaigns.Campaign do
  @moduledoc """
  Campaigns are sets of levels that users can unlock and play. They have an optional number field for ordering.

  When a user unlocks a campaign, it is tracked by the intermediate CampaignUnlocked table.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ChampionsOfMirra.Campaigns.Level

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "campaigns" do
    field(:name, :string)
    field(:number, :integer)

    has_many(:levels, Level)

    timestamps()
  end

  @doc false
  def changeset(character, attrs),
    do:
      character
      |> cast(attrs, [:name, :number])
      |> cast_assoc(:levels)
      |> validate_required([:name])
end
