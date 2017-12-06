defmodule NeuMapWeb.BuildingView do
  use NeuMapWeb, :view

  def get_area!(id) do
    NeuMap.Map.get_area!(id)
  end  

  def get_services(building_id) do
    Enum.filter(NeuMap.Map.list_service(), fn(x) -> x.building_id == building_id end)
  end

  def get_color(service) do
    NeuMap.Map.get_tag!(service.tag_id).color
  end
end
