defmodule NeuMap.Repo.Migrations.CreateArea do
  use Ecto.Migration

  def change do
    create table(:area) do
      add :name, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end

  end
end
