defmodule NeuMap.Map.Building do
  use Ecto.Schema
  import Ecto.Changeset
  alias NeuMap.Map.Building


  schema "building" do
    field :address, :string
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    field :area_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Building{} = building, attrs) do
    building
    |> cast(attrs, [:name, :address, :latitude, :longitude, :area_id])
    |> validate_required([:name, :address, :latitude, :longitude, :area_id])
  end
end
