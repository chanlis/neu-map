defmodule NeuMapWeb.SearchController do
  use NeuMapWeb, :controller

  alias NeuMap.Map

  def index(conn, %{"query" => query}) do 
    results = Map.search_all(query)
    render conn, "index.html", results: results
  end
end
