defmodule NeuMapWeb.PageController do
  use NeuMapWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
