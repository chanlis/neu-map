defmodule NeuMapWeb.BuildingView do
  use NeuMapWeb, :view

  def get_area!(id) do
    NeuMap.Map.get_area!(id)
  end  
end
