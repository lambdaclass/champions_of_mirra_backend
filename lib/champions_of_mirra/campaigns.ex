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

  @doc """
  Insert a campaign into the database.
  """
  def insert_campaign(attrs) do
    %Campaign{}
    |> Campaign.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get all campaigns.
  """
  def get_campaigns(), do: Repo.all(Campaign)

  @doc """
  Get a campaign by ID.
  """
  def get_campaign(id), do: Repo.get(Campaign, id) |> Repo.preload(:levels)

  @doc """
  Get a campaign by name.
  """
  def get_campaign_by_name(name), do: Repo.one(from(c in Campaign, where: c.name == ^name))

  ##########
  # Levels #
  ##########

  @doc """
  Insert a level into the database.
  """
  def insert_level(attrs) do
    %Level{}
    |> Level.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get all levels.
  """
  def get_levels(), do: Repo.all(Level)

  @doc """
  Get all levels for a specific campaign.
  """
  def get_levels(campaign_id), do: Repo.all(from(l in Level, where: l.campaign_id == ^campaign_id))

  @doc """
  Get a level by ID.
  """
  def get_level(id), do: Repo.get(Level, id) |> Repo.preload(units: :character)

  @doc """
  Get a level by name.
  """
  def get_level_by_name(name), do: Repo.one(from(l in Level, where: l.name == ^name))

  ####################
  # CampaignUnlocked #
  ####################

  @doc """
  Insert a record for unlocked campaigns.
  """
  def insert_campaign_unlocked(attrs) do
    %CampaignUnlocked{}
    |> CampaignUnlocked.changeset(attrs)
    |> Repo.insert()
  end

  ##################
  # LevelCompleted #
  ##################

  @doc """
  Insert a record for completed levels.
  """
  def insert_level_completed(attrs) do
    %LevelCompleted{}
    |> LevelCompleted.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Check if a user has completed a specific level.
  """
  def user_completed_level?(user_id, level_id),
    do: Repo.exists?(from(lc in LevelCompleted, where: lc.user_id == ^user_id and lc.level_id == ^level_id))

  @doc """
  Returns the percentage of progress a user has accomplished on a campaign.
  """
  def user_progress(user, campaign) do
    levels = campaign.levels
    completed_levels = Repo.all(from(lc in LevelCompleted, where: lc.user_id == ^user.id))
    100 * length(completed_levels) / length(levels)
  end
end
