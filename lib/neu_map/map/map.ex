defmodule NeuMap.Map do
  @moduledoc """
  The Map context.
  """

  import Ecto.Query, warn: false
  alias NeuMap.Repo

  # searches through all
  # - building.name
  # - building.address
  # - building.area
  # - area.name
  # - service.name
  # - service.tag.name
  # - favorite.name (v2 feature)
  #
  # returns list of ["type", object]
  def search_all(query, user_id) do
    query = String.downcase(query)
    building = Enum.map(search_building(query), fn(x) -> ["building", x] end)
    area = Enum.map(search_area(query), fn(x) -> ["area", x] end)
    service = Enum.map(search_service(query), fn(x) -> ["service", x] end)
    favorite = Enum.map(search_favorite(query, user_id), fn(x) -> ["favorite", x] end)
    
    favorite ++ building ++ area ++ service
  end

  def search_all("", user_id), do: nil

  alias NeuMap.Map.Area

  # search area.name, returns list
  def search_area(query) do
    area = list_area()
    Enum.filter(area, fn(x) -> String.contains?(String.downcase(x.name), query) end)
  end

  @doc """
  Returns the list of area.

  ## Examples

      iex> list_area()
      [%Area{}, ...]

  """
  def list_area do
    Repo.all(Area)
  end

  @doc """
  Gets a single area.

  Raises `Ecto.NoResultsError` if the Area does not exist.

  ## Examples

      iex> get_area!(123)
      %Area{}

      iex> get_area!(456)
      ** (Ecto.NoResultsError)

  """
  def get_area!(nil), do: %{name: ""}

  def get_area!(id), do: Repo.get!(Area, id)

  @doc """
  Creates a area.

  ## Examples

      iex> create_area(%{field: value})
      {:ok, %Area{}}

      iex> create_area(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_area(attrs \\ %{}) do
    %Area{}
    |> Area.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a area.

  ## Examples

      iex> update_area(area, %{field: new_value})
      {:ok, %Area{}}

      iex> update_area(area, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_area(%Area{} = area, attrs) do
    area
    |> Area.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Area.
  ## Examples

      iex> delete_area(area)
      {:ok, %Area{}}

      iex> delete_area(area)
      {:error, %Ecto.Changeset{}}

  """
  def delete_area(%Area{} = area) do
    Repo.delete(area)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking area changes.

  ## Examples

      iex> change_area(area)
      %Ecto.Changeset{source: %Area{}}

  """
  def change_area(%Area{} = area) do
    Area.changeset(area, %{})
  end

  alias NeuMap.Map.Building

  # search building.name and building.address, returns list
  def search_building(query) do
    building = list_building()
    Enum.filter(building, fn(x) -> String.contains?(String.downcase(x.name), query) || String.contains?(String.downcase(get_address(x.address)), query) || String.contains?(String.downcase(get_area!(x.area_id).name), query) end)
  end

  def get_address(address) do
    if address do
      address
    else
      ""
    end
  end

  @doc """
  Returns the list of building.

  ## Examples

      iex> list_building()
      [%Building{}, ...]

  """
  def list_building do
    Repo.all(Building)
  end

  @doc """
  Gets a single building.

  Raises `Ecto.NoResultsError` if the Building does not exist.

  ## Examples

      iex> get_building!(123)
      %Building{}

      iex> get_building!(456)
      ** (Ecto.NoResultsError)

  """
  def get_building!(id), do: Repo.get!(Building, id)

  @doc """
  Creates a building.

  ## Examples

      iex> create_building(%{field: value})
      {:ok, %Building{}}

      iex> create_building(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_building(attrs \\ %{}) do
    %Building{}
    |> Building.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a building.

  ## Examples

      iex> update_building(building, %{field: new_value})
      {:ok, %Building{}}

      iex> update_building(building, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_building(%Building{} = building, attrs) do
    building
    |> Building.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Building.

  ## Examples

      iex> delete_building(building)
      {:ok, %Building{}}

      iex> delete_building(building)
      {:error, %Ecto.Changeset{}}

  """
  def delete_building(%Building{} = building) do
    Repo.delete(building)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking building changes.

  ## Examples

      iex> change_building(building)
      %Ecto.Changeset{source: %Building{}}

  """
  def change_building(%Building{} = building) do
    Building.changeset(building, %{})
  end

  alias NeuMap.Map.Tag

  @doc """
  Returns the list of tag.

  ## Examples

      iex> list_tag()
      [%Tag{}, ...]

  """
  def list_tag do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end

  alias NeuMap.Map.Service

  # search service.name, returns list
  def search_service(query) do
    service = list_service()
    Enum.filter(service, fn(x) -> String.contains?(String.downcase(x.name), query) || String.contains?(String.downcase(get_tag!(x.tag_id).name), query) end)
  end


  @doc """
  Returns the list of service.

  ## Examples

      iex> list_service()
      [%Service{}, ...]

  """
  def list_service do
    Repo.all(Service)
  end

  @doc """
  Gets a single service.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

      iex> get_service!(123)
      %Service{}

      iex> get_service!(456)
      ** (Ecto.NoResultsError)

  """
  def get_service!(id), do: Repo.get!(Service, id)

  @doc """
  Creates a service.

  ## Examples

      iex> create_service(%{field: value})
      {:ok, %Service{}}

      iex> create_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a service.

  ## Examples

      iex> update_service(service, %{field: new_value})
      {:ok, %Service{}}

      iex> update_service(service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Service.

  ## Examples

      iex> delete_service(service)
      {:ok, %Service{}}

      iex> delete_service(service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking service changes.

  ## Examples

      iex> change_service(service)
      %Ecto.Changeset{source: %Service{}}

  """
  def change_service(%Service{} = service) do
    Service.changeset(service, %{})
  end

  alias NeuMap.Map.Favorite

  # search favorite.name, returns list
  def search_favorite(query, user_id) do
    favorites = list_favorite(user_id)
    Enum.filter(favorites, fn(x) -> String.contains?(String.downcase(
      if x.name do
        x.name
      else
        ""
      end
    ), query) end)
  end

  @doc """
  Returns the list of favorite.

  ## Examples

      iex> list_favorite()
      [%Favorite{}, ...]

  """
  def list_favorite() do
    Repo.all(Favorite)
  end

  def list_favorite(user_id) do
    favorites = list_favorite()
    Enum.filter(favorites, fn(x) -> x.user_id == user_id end)
  end

  @doc """
  Gets a single favorite.

  Raises `Ecto.NoResultsError` if the Favorite does not exist.

  ## Examples

      iex> get_favorite!(123)
      %Favorite{}

      iex> get_favorite!(456)
      ** (Ecto.NoResultsError)

  """
  def get_favorite_building(building_id, user_id) do
    favorites = list_favorite()
    Enum.find(favorites, fn(x) -> x.user_id == user_id && x.building_id == building_id end)
  end

  def get_favorite_service(service_id, user_id) do
    favorites = list_favorite()
    Enum.find(favorites, fn(x) -> x.user_id == user_id && x.service_id == service_id end)
  end
  
  def get_favorite!(id), do: Repo.get!(Favorite, id)

  @doc """
  Creates a favorite.

  ## Examples

      iex> create_favorite(%{field: value})
      {:ok, %Favorite{}}

      iex> create_favorite(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_favorite(attrs \\ %{}) do
    %Favorite{}
    |> Favorite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a favorite.

  ## Examples

      iex> update_favorite(favorite, %{field: new_value})
      {:ok, %Favorite{}}

      iex> update_favorite(favorite, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_favorite(%Favorite{} = favorite, attrs) do
    favorite
    |> Favorite.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Favorite.

  ## Examples

      iex> delete_favorite(favorite)
      {:ok, %Favorite{}}

      iex> delete_favorite(favorite)
      {:error, %Ecto.Changeset{}}

  """
  def delete_favorite(%Favorite{} = favorite) do
    Repo.delete(favorite)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking favorite changes.

  ## Examples

      iex> change_favorite(favorite)
      %Ecto.Changeset{source: %Favorite{}}

  """
  def change_favorite(%Favorite{} = favorite) do
    Favorite.changeset(favorite, %{})
  end
end
