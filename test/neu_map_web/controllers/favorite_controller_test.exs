defmodule NeuMapWeb.FavoriteControllerTest do
  use NeuMapWeb.ConnCase

  alias NeuMap.Map
  alias NeuMap.Map.Favorite

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:favorite) do
    {:ok, favorite} = Map.create_favorite(@create_attrs)
    favorite
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all favorite", %{conn: conn} do
      conn = get conn, favorite_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create favorite" do
    test "renders favorite when data is valid", %{conn: conn} do
      conn = post conn, favorite_path(conn, :create), favorite: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, favorite_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, favorite_path(conn, :create), favorite: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update favorite" do
    setup [:create_favorite]

    test "renders favorite when data is valid", %{conn: conn, favorite: %Favorite{id: id} = favorite} do
      conn = put conn, favorite_path(conn, :update, favorite), favorite: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, favorite_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, favorite: favorite} do
      conn = put conn, favorite_path(conn, :update, favorite), favorite: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete favorite" do
    setup [:create_favorite]

    test "deletes chosen favorite", %{conn: conn, favorite: favorite} do
      conn = delete conn, favorite_path(conn, :delete, favorite)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, favorite_path(conn, :show, favorite)
      end
    end
  end

  defp create_favorite(_) do
    favorite = fixture(:favorite)
    {:ok, favorite: favorite}
  end
end
