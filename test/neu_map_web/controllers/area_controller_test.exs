defmodule NeuMapWeb.AreaControllerTest do
  use NeuMapWeb.ConnCase

  alias NeuMap.Map

  @create_attrs %{latitude: 120.5, longitude: 120.5, name: "some name"}
  @update_attrs %{latitude: 456.7, longitude: 456.7, name: "some updated name"}
  @invalid_attrs %{latitude: nil, longitude: nil, name: nil}

  def fixture(:area) do
    {:ok, area} = Map.create_area(@create_attrs)
    area
  end

  describe "index" do
    test "lists all area", %{conn: conn} do
      conn = get conn, area_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Area"
    end
  end

  describe "new area" do
    test "renders form", %{conn: conn} do
      conn = get conn, area_path(conn, :new)
      assert html_response(conn, 200) =~ "New Area"
    end
  end

  describe "create area" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, area_path(conn, :create), area: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == area_path(conn, :show, id)

      conn = get conn, area_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Area"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, area_path(conn, :create), area: @invalid_attrs
      assert html_response(conn, 200) =~ "New Area"
    end
  end

  describe "edit area" do
    setup [:create_area]

    test "renders form for editing chosen area", %{conn: conn, area: area} do
      conn = get conn, area_path(conn, :edit, area)
      assert html_response(conn, 200) =~ "Edit Area"
    end
  end

  describe "update area" do
    setup [:create_area]

    test "redirects when data is valid", %{conn: conn, area: area} do
      conn = put conn, area_path(conn, :update, area), area: @update_attrs
      assert redirected_to(conn) == area_path(conn, :show, area)

      conn = get conn, area_path(conn, :show, area)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, area: area} do
      conn = put conn, area_path(conn, :update, area), area: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Area"
    end
  end

  describe "delete area" do
    setup [:create_area]

    test "deletes chosen area", %{conn: conn, area: area} do
      conn = delete conn, area_path(conn, :delete, area)
      assert redirected_to(conn) == area_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, area_path(conn, :show, area)
      end
    end
  end

  defp create_area(_) do
    area = fixture(:area)
    {:ok, area: area}
  end
end
