defmodule NeuMap.MapTest do
  use NeuMap.DataCase

  alias NeuMap.Map


  describe "area" do
    alias NeuMap.Map.Area

    @valid_attrs %{latitude: 120.5, longitude: 120.5, name: "some name"}
    @update_attrs %{latitude: 456.7, longitude: 456.7, name: "some updated name"}
    @invalid_attrs %{latitude: nil, longitude: nil, name: nil}

    def area_fixture(attrs \\ %{}) do
      {:ok, area} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.create_area()

      area
    end

    test "list_area/0 returns all area" do
      area = area_fixture()
      assert Map.list_area() == [area]
    end

    test "get_area!/1 returns the area with given id" do
      area = area_fixture()
      assert Map.get_area!(area.id) == area
    end

    test "create_area/1 with valid data creates a area" do
      assert {:ok, %Area{} = area} = Map.create_area(@valid_attrs)
      assert area.latitude == 120.5
      assert area.longitude == 120.5
      assert area.name == "some name"
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Map.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      area = area_fixture()
      assert {:ok, area} = Map.update_area(area, @update_attrs)
      assert %Area{} = area
      assert area.latitude == 456.7
      assert area.longitude == 456.7
      assert area.name == "some updated name"
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = area_fixture()
      assert {:error, %Ecto.Changeset{}} = Map.update_area(area, @invalid_attrs)
      assert area == Map.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = area_fixture()
      assert {:ok, %Area{}} = Map.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> Map.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = area_fixture()
      assert %Ecto.Changeset{} = Map.change_area(area)
    end
  end

  describe "building" do
    alias NeuMap.Map.Building

    @valid_attrs %{address: "some address", latitude: 120.5, longitude: 120.5, name: "some name"}
    @update_attrs %{address: "some updated address", latitude: 456.7, longitude: 456.7, name: "some updated name"}
    @invalid_attrs %{address: nil, latitude: nil, longitude: nil, name: nil}

    def building_fixture(attrs \\ %{}) do
      {:ok, building} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.create_building()

      building
    end

    test "list_building/0 returns all building" do
      building = building_fixture()
      assert Map.list_building() == [building]
    end

    test "get_building!/1 returns the building with given id" do
      building = building_fixture()
      assert Map.get_building!(building.id) == building
    end

    test "create_building/1 with valid data creates a building" do
      assert {:ok, %Building{} = building} = Map.create_building(@valid_attrs)
      assert building.address == "some address"
      assert building.latitude == 120.5
      assert building.longitude == 120.5
      assert building.name == "some name"
    end

    test "create_building/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Map.create_building(@invalid_attrs)
    end

    test "update_building/2 with valid data updates the building" do
      building = building_fixture()
      assert {:ok, building} = Map.update_building(building, @update_attrs)
      assert %Building{} = building
      assert building.address == "some updated address"
      assert building.latitude == 456.7
      assert building.longitude == 456.7
      assert building.name == "some updated name"
    end

    test "update_building/2 with invalid data returns error changeset" do
      building = building_fixture()
      assert {:error, %Ecto.Changeset{}} = Map.update_building(building, @invalid_attrs)
      assert building == Map.get_building!(building.id)
    end

    test "delete_building/1 deletes the building" do
      building = building_fixture()
      assert {:ok, %Building{}} = Map.delete_building(building)
      assert_raise Ecto.NoResultsError, fn -> Map.get_building!(building.id) end
    end

    test "change_building/1 returns a building changeset" do
      building = building_fixture()
      assert %Ecto.Changeset{} = Map.change_building(building)
    end
  end

  describe "tag" do
    alias NeuMap.Map.Tag

    @valid_attrs %{color: "some color", name: "some name"}
    @update_attrs %{color: "some updated color", name: "some updated name"}
    @invalid_attrs %{color: nil, name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.create_tag()

      tag
    end

    test "list_tag/0 returns all tag" do
      tag = tag_fixture()
      assert Map.list_tag() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Map.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Map.create_tag(@valid_attrs)
      assert tag.color == "some color"
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Map.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, tag} = Map.update_tag(tag, @update_attrs)
      assert %Tag{} = tag
      assert tag.color == "some updated color"
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Map.update_tag(tag, @invalid_attrs)
      assert tag == Map.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Map.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Map.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Map.change_tag(tag)
    end
  end

  describe "service" do
    alias NeuMap.Map.Service

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.create_service()

      service
    end

    test "list_service/0 returns all service" do
      service = service_fixture()
      assert Map.list_service() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Map.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Map.create_service(@valid_attrs)
      assert service.description == "some description"
      assert service.name == "some name"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Map.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, service} = Map.update_service(service, @update_attrs)
      assert %Service{} = service
      assert service.description == "some updated description"
      assert service.name == "some updated name"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Map.update_service(service, @invalid_attrs)
      assert service == Map.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Map.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Map.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Map.change_service(service)
    end
  end

  describe "favorite" do
    alias NeuMap.Map.Favorite

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def favorite_fixture(attrs \\ %{}) do
      {:ok, favorite} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.create_favorite()

      favorite
    end

    test "list_favorite/0 returns all favorite" do
      favorite = favorite_fixture()
      assert Map.list_favorite() == [favorite]
    end

    test "get_favorite!/1 returns the favorite with given id" do
      favorite = favorite_fixture()
      assert Map.get_favorite!(favorite.id) == favorite
    end

    test "create_favorite/1 with valid data creates a favorite" do
      assert {:ok, %Favorite{} = favorite} = Map.create_favorite(@valid_attrs)
      assert favorite.name == "some name"
    end

    test "create_favorite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Map.create_favorite(@invalid_attrs)
    end

    test "update_favorite/2 with valid data updates the favorite" do
      favorite = favorite_fixture()
      assert {:ok, favorite} = Map.update_favorite(favorite, @update_attrs)
      assert %Favorite{} = favorite
      assert favorite.name == "some updated name"
    end

    test "update_favorite/2 with invalid data returns error changeset" do
      favorite = favorite_fixture()
      assert {:error, %Ecto.Changeset{}} = Map.update_favorite(favorite, @invalid_attrs)
      assert favorite == Map.get_favorite!(favorite.id)
    end

    test "delete_favorite/1 deletes the favorite" do
      favorite = favorite_fixture()
      assert {:ok, %Favorite{}} = Map.delete_favorite(favorite)
      assert_raise Ecto.NoResultsError, fn -> Map.get_favorite!(favorite.id) end
    end

    test "change_favorite/1 returns a favorite changeset" do
      favorite = favorite_fixture()
      assert %Ecto.Changeset{} = Map.change_favorite(favorite)
    end
  end
end
