defmodule NeuMapWeb.BuildingController do
  use NeuMapWeb, :controller

  alias NeuMap.Map
  alias NeuMap.Map.Building

  def index(conn, _params) do
    building = Map.list_building()
    render(conn, "index.html", building: building)
  end

  def new(conn, _params) do
    changeset = Map.change_building(%Building{})
    area_list = Map.list_area()
    |> Enum.map(&{&1.name, &1.id})
    area_list = [{"none", nil}] ++ area_list
    render(conn, "new.html", changeset: changeset, area_list: area_list)
  end

  def create(conn, %{"building" => building_params}) do
    case Map.create_building(building_params) do
      {:ok, building} ->
        conn
        |> put_flash(:info, "Building created successfully.")
        |> redirect(to: building_path(conn, :show, building))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    building = Map.get_building!(id)
    user_id = get_session(conn, :user_id)
    favorite = Map.get_favorite_building(building.id, user_id)
    render(conn, "show.html", building: building, favorite: favorite)
  end

  def edit(conn, %{"id" => id}) do
    building = Map.get_building!(id)
    changeset = Map.change_building(building)
    area_list = Map.list_area()
    |> Enum.map(&{&1.name, &1.id})
    area_list = [{"none", nil}] ++ area_list
    render(conn, "edit.html", area_list: area_list, building: building, changeset: changeset)
  end

  def update(conn, %{"id" => id, "building" => building_params}) do
    building = Map.get_building!(id)

    case Map.update_building(building, building_params) do
      {:ok, building} ->
        conn
        |> put_flash(:info, "Building updated successfully.")
        |> redirect(to: building_path(conn, :show, building))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", building: building, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    building = Map.get_building!(id)
    {:ok, _building} = Map.delete_building(building)

    conn
    |> put_flash(:info, "Building deleted successfully.")
    |> redirect(to: building_path(conn, :index))
  end
end
