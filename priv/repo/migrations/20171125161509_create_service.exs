defmodule NeuMap.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:service) do
      add :name, :string
      add :description, :string
      add :building_id, references(:building, on_delete: :delete_all)
      add :tag_id, references(:tag, on_delete: :delete_all)

      timestamps()
    end

    create index(:service, [:building_id])
    create index(:service, [:tag_id])
  end
end
