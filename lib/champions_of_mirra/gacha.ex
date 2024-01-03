defmodule ChampionsOfMirra.Gacha do
  @moduledoc """
  Operations for the Gacha system.
  """

  import Ecto.Query
  alias ChampionsOfMirra.Gacha.Box
  alias ChampionsOfMirra.Repo
  alias ChampionsOfMirra.Units

  @doc """

  """
  def insert_box(attrs) do
    %Box{}
    |> Box.changeset(attrs)
    |> Repo.insert()
  end

  def get_box(id), do: Repo.get(Box, id) |> Repo.preload(:character_drop_rates)

  def get_box_by_name(name), do: Repo.one(from(b in Box, where: b.name == ^name))

  def get_boxes(), do: Repo.all(Box)

  def pull(user, box) do
    character_drop_rates = box.character_drop_rates |> Enum.sort(&(&1.weight >= &2.weight))

    total_weight = Enum.reduce(character_drop_rates, 0, fn drop_rate, acc -> drop_rate.weight + acc end)

    character_id =
      Enum.reduce_while(character_drop_rates, Enum.random(1..total_weight), fn drop_rate, acc_weight ->
        acc_weight = acc_weight - drop_rate.weight
        if acc_weight <= 0, do: {:halt, drop_rate.character_id}, else: {:cont, acc_weight}
      end)

    case Units.insert_unit(%{character_id: character_id, level: 99, selected: false, user_id: user.id}) do
      {:error, reason} -> {:error, reason}
      {:ok, unit} -> {:ok, unit}
    end
  end
end
