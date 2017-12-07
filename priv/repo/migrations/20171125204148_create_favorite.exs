defmodule NeuMap.Repo.Migrations.CreateFavorite do
  use Ecto.Migration

  def change do
    create table(:favorite) do
      add :name, :string
      add :building_id, references(:building, on_delete: :delete_all)
      add :service_id, references(:service, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:favorite, [:building_id])
    create index(:favorite, [:service_id])
    create index(:favorite, [:user_id])
  end
end
