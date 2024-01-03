defmodule ChampionsOfMirraWeb.CampaignController do
  use ChampionsOfMirraWeb, :controller
  alias ChampionsOfMirra.Accounts
  alias ChampionsOfMirra.Campaigns
  alias ChampionsOfMirra.Campaigns.Campaign
  alias ChampionsOfMirra.Campaigns.Level
  alias ChampionsOfMirra.Repo

  def get_campaigns(conn, %{"device_client_id" => device_client_id}) do
    case Accounts.get_user_by_device_client_id(device_client_id) |> Repo.preload(unlocked_campaigns: :levels) do
      nil ->
        json(conn, %{error: "INEXISTENT_USER"})

      user ->
        json(conn, Enum.map(user.unlocked_campaigns, &format_campaign(&1, user)))
    end
  end

  def get_campaign(conn, %{"device_client_id" => device_client_id, "campaign_id" => campaign_id}) do
    case Accounts.get_user_by_device_client_id(device_client_id) do
      nil ->
        json(conn, %{error: "INEXISTENT_USER"})

      user ->
        with %Campaign{} = campaign <- Campaigns.get_campaign(campaign_id),
             campaign_map <- format_campaign(campaign, user),
             levels <- Enum.map(campaign.levels, &format_level(&1, user)),
             campaign_map <- Map.put(campaign_map, :levels, levels) do
          json(conn, campaign_map)
        else
          nil -> json(conn, %{error: "INEXISTENT_CAMPAIGN"})
        end
    end
  end

  defp format_campaign(%Campaign{name: name, number: number, id: id} = campaign, user) do
    %{id: id, name: name, number: number, progress: Campaigns.user_progress(user, campaign)}
  end

  defp format_level(%Level{name: name, number: number, id: id} = level, user) do
    %{name: name, number: number, id: id, completed: Campaigns.user_completed_level?(user.id, level.id)}
  end
end
