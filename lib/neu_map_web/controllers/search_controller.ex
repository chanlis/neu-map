defmodule NeuMapWeb.SearchController do
  use NeuMapWeb, :controller

  alias NeuMap.Map

  def index(conn, %{"query" => query}) do 
    user = get_session(conn, :user_id)
    results = Map.search_all(query, user)
    render conn, "index.html", results: results
  end
end
