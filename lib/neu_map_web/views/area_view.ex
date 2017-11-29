defmodule NeuMapWeb.AreaView do
  use NeuMapWeb, :view

  def get_buildings(nil), do: nil

  def get_buildings(area_id) do
    Enum.filter(NeuMap.Map.list_building(), fn(x) -> x.area_id == area_id end)
  end
end
