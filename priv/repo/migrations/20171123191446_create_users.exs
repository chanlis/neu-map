defmodule NeuMap.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :is_admin?, :boolean, null: false, default: false
      add :password_hash, :string
      add :pw_last_try, :utc_datetime
      add :pw_tries, :integer, null: false, default: 0

      timestamps()
    end

  end
end
