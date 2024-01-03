defmodule ChampionsOfMirra.Repo.Migrations.AddCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add(:name, :string)
      add(:number, :integer)
      timestamps()
    end

    create table(:campaign_unlocked) do
      add(:campaign_id, references(:campaigns), null: false)
      add(:user_id, references(:users), null: false)
      timestamps()
    end

    create table(:levels) do
      add(:name, :string)
      add(:number, :integer)
      add(:campaign_id, references(:campaigns), null: false)
      timestamps()
    end

    drop constraint(:units, "units_user_id_fkey")
    alter table(:units) do
      modify(:user_id, references(:users), null: true)
      add(:campaign_level_id, references(:levels), null: true)
    end

    create table(:level_completed) do
      add(:level_id, references(:levels), null: false)
      add(:user_id, references(:users), null: false)
      add(:rating, :string)
      timestamps()
    end

    create unique_index(:campaigns, :name)
    create unique_index(:campaigns, :number)
    create unique_index(:levels, :name)
    create unique_index(:levels, [:campaign_id, :number])
  end
end
