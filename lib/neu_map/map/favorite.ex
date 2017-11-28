defmodule NeuMap.Map.Favorite do
  use Ecto.Schema
  import Ecto.Changeset
  alias NeuMap.Map.Favorite


  schema "favorite" do
    field :name, :string
    field :building_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Favorite{} = favorite, attrs) do
    favorite
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
