defmodule NeuMap.Repo.Migrations.CreateBuilding do
  use Ecto.Migration

  def change do
    create table(:building) do
      add :name, :string
      add :address, :string
      add :latitude, :float
      add :longitude, :float
      add :area_id, references(:area, on_delete: :delete_all)

      timestamps()
    end

    create index(:building, [:area_id])
  end
end
