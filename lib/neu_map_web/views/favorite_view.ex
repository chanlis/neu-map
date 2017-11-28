defmodule NeuMapWeb.FavoriteView do
  use NeuMapWeb, :view
  alias NeuMapWeb.FavoriteView

  def render("index.json", %{favorite: favorite}) do
    %{data: render_many(favorite, FavoriteView, "favorite.json")}
  end

  def render("show.json", %{favorite: favorite}) do
    %{data: render_one(favorite, FavoriteView, "favorite.json")}
  end

  def render("favorite.json", %{favorite: favorite}) do
    %{id: favorite.id,
      name: favorite.name}
  end
end
