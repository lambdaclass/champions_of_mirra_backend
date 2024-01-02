defmodule ChampionsOfMirra.Repo.Migrations.CreateConfigs do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      timestamps()
    end

    create unique_index(:characters, :name)
  end
end
