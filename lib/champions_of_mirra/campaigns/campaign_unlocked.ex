defmodule ChampionsOfMirra.Campaigns.CampaignUnlocked do
  @moduledoc """
  The user-level association intermediate table.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ChampionsOfMirra.Accounts.User
  alias ChampionsOfMirra.Campaigns.Campaign

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "campaign_unlocked" do
    belongs_to(:user, User)
    belongs_to(:campaign, Campaign)

    timestamps()
  end

  @doc false
  def changeset(campaign_unlocked, attrs) do
    campaign_unlocked
    |> cast(attrs, [:user_id, :campaign_id])
    |> validate_required([:user_id, :campaign_id])
  end
end
