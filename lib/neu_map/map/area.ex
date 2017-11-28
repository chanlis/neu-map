defmodule NeuMap.Map.Area do
  use Ecto.Schema
  import Ecto.Changeset
  alias NeuMap.Map.Area


  schema "area" do
    field :latitude, :float
    field :longitude, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Area{} = area, attrs) do
    area
    |> cast(attrs, [:name, :latitude, :longitude])
    |> validate_required([:name, :latitude, :longitude])
  end
end
