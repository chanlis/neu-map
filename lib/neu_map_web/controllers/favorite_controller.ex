defmodule NeuMapWeb.FavoriteController do
  use NeuMapWeb, :controller

  alias NeuMap.Map
  alias NeuMap.Map.Favorite

  action_fallback NeuMapWeb.FallbackController

  def index(conn, _params) do
    favorite = Map.list_favorite()
    render(conn, "index.json", favorite: favorite)
  end

  def create(conn, %{"favorite" => favorite_params}) do
    with {:ok, %Favorite{} = favorite} <- Map.create_favorite(favorite_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", favorite_path(conn, :show, favorite))
      |> render("show.json", favorite: favorite)
    end
  end

  def show(conn, %{"id" => id}) do
    favorite = Map.get_favorite!(id)
    render(conn, "show.json", favorite: favorite)
  end

  def update(conn, %{"id" => id, "favorite" => favorite_params}) do
    favorite = Map.get_favorite!(id)

    with {:ok, %Favorite{} = favorite} <- Map.update_favorite(favorite, favorite_params) do
      render(conn, "show.json", favorite: favorite)
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Map.get_favorite!(id)
    with {:ok, %Favorite{}} <- Map.delete_favorite(favorite) do
      send_resp(conn, :no_content, "")
    end
  end
end
