defmodule NeuMap.Map.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias NeuMap.Map.Tag


  schema "tag" do
    field :color, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
  end
end
