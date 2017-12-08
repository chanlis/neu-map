defmodule NeuMapWeb.AreaController do
  use NeuMapWeb, :controller

  alias NeuMap.Map
  alias NeuMap.Map.Area

  def index(conn, _params) do
    area = Enum.sort_by(Map.list_area(), fn(x) -> String.downcase(x.name) end)
    render(conn, "index.html", area: area)
  end

  def new(conn, _params) do
    changeset = Map.change_area(%Area{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"area" => area_params}) do
    case Map.create_area(area_params) do
      {:ok, area} ->
        conn
        |> put_flash(:info, "Area created successfully.")
        |> redirect(to: area_path(conn, :show, area))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    area = Map.get_area!(id)
    render(conn, "show.html", area: area)
  end

  def edit(conn, %{"id" => id}) do
    area = Map.get_area!(id)
    changeset = Map.change_area(area)
    render(conn, "edit.html", area: area, changeset: changeset)
  end

  def update(conn, %{"id" => id, "area" => area_params}) do
    area = Map.get_area!(id)

    case Map.update_area(area, area_params) do
      {:ok, area} ->
        conn
        |> put_flash(:info, "Area updated successfully.")
        |> redirect(to: area_path(conn, :show, area))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", area: area, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    area = Map.get_area!(id)
    {:ok, _area} = Map.delete_area(area)

    conn
    |> put_flash(:info, "Area deleted successfully.")
    |> redirect(to: area_path(conn, :index))
  end
end
