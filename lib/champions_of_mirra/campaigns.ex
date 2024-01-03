defmodule ChampionsOfMirra.Campaigns do
  @moduledoc """
  Operations involving campaigns.
  """

  import Ecto.Query

  alias ChampionsOfMirra.Campaigns.Campaign
  alias ChampionsOfMirra.Campaigns.CampaignUnlocked
  alias ChampionsOfMirra.Campaigns.Level
  alias ChampionsOfMirra.Campaigns.LevelCompleted
  alias ChampionsOfMirra.Repo

  #############
  # Campaigns #
  #############

  def insert_campaign(attrs \\ %{}) do
    %Campaign{}
    |> Campaign.changeset(attrs)
    |> Repo.insert()
  end

  def get_campaign(id), do: Repo.get(Campaign, id)

  def get_campaigns(), do: Repo.all(Campaign)

  def get_campaign_by_name(name), do: Repo.one(from(c in Campaign, where: c.name == ^name))

  ##########
  # Levels #
  ##########

  def insert_level(attrs \\ %{}) do
    %Level{}
    |> Level.changeset(attrs)
    |> Repo.insert()
  end

  def get_level(id), do: Repo.get(Level, id)

  def get_levels(), do: Repo.all(Level)

  def get_levels(campaign_id), do: Repo.all(from(l in Level, where: l.campaign_id == ^campaign_id))

  def get_level_by_name(name), do: Repo.one(from(l in Level, where: l.name == ^name))

  ####################
  # CampaignUnlocked #
  ####################

  def insert_campaign_unlocked(attrs \\ %{}) do
    %CampaignUnlocked{}
    |> CampaignUnlocked.changeset(attrs)
    |> Repo.insert()
  end

  ##################
  # LevelCompleted #
  ##################

  def insert_level_completed(attrs \\ %{}) do
    %LevelCompleted{}
    |> LevelCompleted.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the percentage of progress a user has accomplished on a campaign.
  """
  def user_progress(user, campaign) do
    levels = campaign.levels
    completed_levels = Repo.all(from(lc in LevelCompleted, where: lc.user_id == ^user.id))
    100 * length(completed_levels) / length(levels)
  end
end
