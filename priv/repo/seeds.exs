# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NeuMap.Repo.insert!(%NeuMap.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NeuMap.Repo
alias NeuMap.Accounts.User
alias NeuMap.Map.Building
alias NeuMap.Map.Area
alias NeuMap.Map.Service
alias NeuMap.Map.Tag

Repo.delete_all(User)
Repo.delete_all(Building)
Repo.delete_all(Area)
Repo.delete_all(Service)
Repo.delete_all(Tag)

Repo.insert!(%User{email: "admin@example.com", name: "Admin", is_admin?: true, password: "neumapadmin", password_confirmation: "neumapadmin", password_hash: Comeonin.Argon2.hashpwsalt("neumapadmin")})
Repo.insert!(%User{email: "test@example.com", name: "Test", is_admin?: false, password: "neumaptest", password_confirmation: "neumaptest", password_hash: Comeonin.Argon2.hashpwsalt("neumaptest")})

defmodule NeuMap.Seeds do
  def insert_area(area) do
    changeset = Area.changeset(%Area{}, area)
    Repo.insert!(changeset)
  end

  def insert_building(building) do
    changeset = Building.changeset(%Building{}, building)
    Repo.insert!(changeset)
  end

  def insert_tag(tag) do
    changeset = Tag.changeset(%Tag{}, tag)
    Repo.insert!(changeset)
  end

  def insert_service(service) do
    changeset = Service.changeset(%Service{}, service)
    Repo.insert!(changeset)
  end
end

File.stream!("/home/lisa/neu-map/priv/repo/csv/Areas.csv")
  |> CSV.decode(headers: [:name, :latitude, :longitude])
  |> Enum.each(&NeuMap.Seeds.insert_area/1)

File.stream!("/home/lisa/neu-map/priv/repo/csv/Buildings.csv")
  |> CSV.decode(headers: [:name, :address, :latitude, :longitude, :area_id])
  |> Enum.each(&NeuMap.Seeds.insert_building/1)

File.stream!("/home/lisa/neu-map/priv/repo/csv/Tags.csv")
  |> CSV.decode(headers: [:name, :color])
  |> Enum.each(&NeuMap.Seeds.insert_tag/1)

File.stream!("/home/lisa/neu-map/priv/repo/csv/Services.csv")
  |> CSV.decode(headers: [:name, :description, :building_id, :tag_id])
  |> Enum.each(&NeuMap.Seeds.insert_service/1)
