defmodule NeuMapWeb.BuildingControllerTest do
  use NeuMapWeb.ConnCase

  alias NeuMap.Map

  @create_attrs %{address: "some address", latitude: 120.5, longitude: 120.5, name: "some name"}
  @update_attrs %{address: "some updated address", latitude: 456.7, longitude: 456.7, name: "some updated name"}
  @invalid_attrs %{address: nil, latitude: nil, longitude: nil, name: nil}

  def fixture(:building) do
    {:ok, building} = Map.create_building(@create_attrs)
    building
  end

  describe "index" do
    test "lists all building", %{conn: conn} do
      conn = get conn, building_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Building"
    end
  end

  describe "new building" do
    test "renders form", %{conn: conn} do
      conn = get conn, building_path(conn, :new)
      assert html_response(conn, 200) =~ "New Building"
    end
  end

  describe "create building" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, building_path(conn, :create), building: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == building_path(conn, :show, id)

      conn = get conn, building_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Building"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, building_path(conn, :create), building: @invalid_attrs
      assert html_response(conn, 200) =~ "New Building"
    end
  end

  describe "edit building" do
    setup [:create_building]

    test "renders form for editing chosen building", %{conn: conn, building: building} do
      conn = get conn, building_path(conn, :edit, building)
      assert html_response(conn, 200) =~ "Edit Building"
    end
  end

  describe "update building" do
    setup [:create_building]

    test "redirects when data is valid", %{conn: conn, building: building} do
      conn = put conn, building_path(conn, :update, building), building: @update_attrs
      assert redirected_to(conn) == building_path(conn, :show, building)

      conn = get conn, building_path(conn, :show, building)
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, building: building} do
      conn = put conn, building_path(conn, :update, building), building: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Building"
    end
  end

  describe "delete building" do
    setup [:create_building]

    test "deletes chosen building", %{conn: conn, building: building} do
      conn = delete conn, building_path(conn, :delete, building)
      assert redirected_to(conn) == building_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, building_path(conn, :show, building)
      end
    end
  end

  defp create_building(_) do
    building = fixture(:building)
    {:ok, building: building}
  end
end
