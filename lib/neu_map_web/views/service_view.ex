defmodule NeuMapWeb.ServiceView do
  use NeuMapWeb, :view

  def get_building!(id) do
    NeuMap.Map.get_building!(id)
  end  
end
