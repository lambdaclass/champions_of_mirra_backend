defmodule ChampionsOfMirra.Repo.Migrations.AddGachaBoxes do
  use Ecto.Migration

  def change do
    create table(:boxes) do
      add :name, :string
      add :description, :string
      timestamps()
    end

    create table(:character_drop_rates) do
      add :box_id, references(:boxes), null: false
      add :character_id, references(:characters), null: false
      add :weight, :integer, null: false
      timestamps()
    end

    create unique_index(:boxes, :name)
    create unique_index(:character_drop_rates, [:box_id, :character_id])
  end
end
