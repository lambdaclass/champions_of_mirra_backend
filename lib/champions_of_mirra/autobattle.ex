defmodule ChampionsOfMirra.Autobattle do
  @moduledoc """
  The Autobattle module focuses on simulating the fights between teams, wether they are PvE or PvP.

  Fight outcomes are decided randomly, favoring the team with the higher aggregate level.
  """

  alias ChampionsOfMirra.Units

  @doc """
  Run an automatic battle between two users. Only validation done is for empty teams.

  Returns the id of the winner.
  """
  def pvp_battle(user_1, user_2) do
    user_1_units = Units.get_selected_units(user_1)
    user_2_units = Units.get_selected_units(user_2)

    cond do
      user_1_units == [] ->
        {:error, {:user_1, :no_selected_units}}

      user_2_units == [] ->
        {:error, {:user_2, :no_selected_units}}

      true ->
        case battle(user_1_units, user_2_units) do
          :team_1 -> user_1
          :team_2 -> user_2
        end
    end
  end

  @doc """
  Run a battle between two teams. The outcome is decided randomly, favoring the team
  with the higher aggregate level of their selected units. Returns `:team_1` or `:team_2`.
  """
  def battle(team_1, team_2) do
    team_1_agg_level = Enum.reduce(team_1, 0, fn unit, acc -> unit.level + acc end)
    team_2_agg_level = Enum.reduce(team_2, 0, fn unit, acc -> unit.level + acc end)
    total_level = team_1_agg_level + team_2_agg_level

    if Enum.random(1..total_level) <= team_1_agg_level, do: :team_1, else: :team_2
  end
end
