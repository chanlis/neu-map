defmodule NeuMap.Map.Service do
  use Ecto.Schema
  import Ecto.Changeset
  alias NeuMap.Map.Service


  schema "service" do
    field :description, :string
    field :name, :string
    field :building_id, :id
    field :tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [:name, :description, :building_id, :tag_id])
    |> validate_required([:name, :building_id, :tag_id])
    |> foreign_key_constraint(:building_id)
    |> foreign_key_constraint(:tag_id)
  end
end
