defmodule ChampionsOfMirraWeb.CampaignController do
  use ChampionsOfMirraWeb, :controller
  alias ChampionsOfMirra.Accounts
  alias ChampionsOfMirra.Campaigns
  alias ChampionsOfMirra.Campaigns.Campaign
  alias ChampionsOfMirra.Repo

  def get_campaigns(conn, %{"device_client_id" => device_client_id}) do
    case Accounts.get_user_by_device_client_id(device_client_id) |> Repo.preload(unlocked_campaigns: :levels) do
      nil ->
        json(conn, %{error: "INEXISTENT_USER"})

      user ->
        json(conn, Enum.map(user.unlocked_campaigns, &format_campaign(&1, user)))
    end
  end

  defp format_campaign(%Campaign{name: name, number: number, id: id} = campaign, user) do
    %{id: id, name: name, number: number, progress: Campaigns.user_progress(user, campaign)}
  end
end
