defmodule NeuMapWeb.TagView do
  use NeuMapWeb, :view

  def get_services(nil), do: nil

  def get_services(tag_id) do
    Enum.filter(NeuMap.Map.list_service(), fn(x) -> x.tag_id == tag_id end)
  end
end
