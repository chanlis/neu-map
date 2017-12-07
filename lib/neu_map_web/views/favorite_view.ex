defmodule NeuMapWeb.FavoriteView do
  use NeuMapWeb, :view
  alias NeuMapWeb.FavoriteView

  def get_name(favorite) do 
    cond do
      favorite.name ->
        favorite.name
      favorite.building_id ->
        NeuMap.Map.get_building!(favorite.building_id).name
      favorite.service_id ->
        NeuMap.Map.get_service!(favorite.service_id).name
    end
  end

  def get_path(favorite) do
    if favorite.building_id do
      "/building/#{favorite.building_id}"
    else
      "/service/#{favorite.service_id}"
    end
  end
end
