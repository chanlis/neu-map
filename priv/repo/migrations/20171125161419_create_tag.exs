defmodule NeuMap.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tag) do
      add :name, :string
      add :color, :string

      timestamps()
    end

  end
end
