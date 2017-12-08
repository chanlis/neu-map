defmodule NeuMapWeb.ServiceController do
  use NeuMapWeb, :controller

  alias NeuMap.Map
  alias NeuMap.Map.Service

  def index(conn, _params) do
    service = Enum.sort_by(Map.list_service(), fn(x) -> String.downcase(x.name) end)
    render(conn, "index.html", service: service)
  end

  def new(conn, _params) do
    changeset = Map.change_service(%Service{})
    building_list = Map.list_building() |> Enum.map(&{&1.name, &1.id})
    tag_list = Map.list_tag() |> Enum.map(&{&1.name, &1.id})
    render(conn, "new.html", changeset: changeset, building_list: building_list, tag_list: tag_list)
  end

  def create(conn, %{"service" => service_params}) do
    case Map.create_service(service_params) do
      {:ok, service} ->
        conn
        |> put_flash(:info, "Service created successfully.")
        |> redirect(to: service_path(conn, :show, service))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    service = Map.get_service!(id)
    user_id = get_session(conn, :user_id)
    favorite = Map.get_favorite_service(service.id, user_id)
    render(conn, "show.html", service: service, favorite: favorite)
  end

  def edit(conn, %{"id" => id}) do
    service = Map.get_service!(id)
    changeset = Map.change_service(service)
    building_list = Map.list_building() |> Enum.map(&{&1.name, &1.id})
    tag_list = Map.list_tag() |> Enum.map(&{&1.name, &1.id})
    render(conn, "edit.html", service: service, changeset: changeset, building_list: building_list, tag_list: tag_list)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = Map.get_service!(id)

    case Map.update_service(service, service_params) do
      {:ok, service} ->
        conn
        |> put_flash(:info, "Service updated successfully.")
        |> redirect(to: service_path(conn, :show, service))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", service: service, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Map.get_service!(id)
    {:ok, _service} = Map.delete_service(service)

    conn
    |> put_flash(:info, "Service deleted successfully.")
    |> redirect(to: service_path(conn, :index))
  end
end
