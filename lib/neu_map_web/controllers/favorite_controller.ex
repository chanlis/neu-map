defmodule NeuMapWeb.FavoriteController do
  use NeuMapWeb, :controller

  alias NeuMap.Map
  alias NeuMap.Map.Favorite
  alias NeuMapWeb.FavoriteView

  action_fallback NeuMapWeb.FallbackController

  def index(conn, _params) do
    user = get_session(conn, :user_id)
    favorite = Enum.sort_by(Map.list_favorite(user), fn(x) -> String.downcase(FavoriteView.get_name(x)) end)

    render(conn, "index.html", favorite: favorite)
  end

  def create(conn, %{"name" => name, "building_id" => building_id, "service_id" => service_id, "user_id" => user_id}) do
    with {:ok, %Favorite{} = favorite} <- Map.create_favorite(%{"name" => name, "building_id" => building_id, "service_id" => service_id, "user_id" => user_id}) do
      IO.puts building_id
      if building_id != "" do
        conn
        |> redirect(to: building_path(conn, :show, building_id))
      else
        conn
        |> redirect(to: service_path(conn, :show, service_id))
      end
    end
  end

  def edit(conn, %{"id" => id}) do
    favorite = Map.get_favorite!(id)
    changeset = Map.change_favorite(favorite)
    render(conn, "edit.html", favorite: favorite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "favorite" => favorite_params}) do
    favorite = Map.get_favorite!(id)

    case Map.update_favorite(favorite, favorite_params) do
      {:ok, favorite} ->
        conn
        |> redirect(to: favorite_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", favorite: favorite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Map.get_favorite!(id)
    with {:ok, %Favorite{}} <- Map.delete_favorite(favorite) do
      current_page = List.first(conn |> get_req_header("referer"))
      cond do
        String.contains?(current_page, "favorite") ->
          conn
          |> redirect(to: favorite_path(conn, :index))
        String.contains?(current_page, "building") ->
          conn
          |> redirect(to: building_path(conn, :show, favorite.building_id))
        String.contains?(current_page, "service") ->
          conn
          |> redirect(to: service_path(conn, :show, favorite.service_id))
      end
    end
  end
end
