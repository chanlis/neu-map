defmodule NeuMapWeb.Router do
  use NeuMapWeb, :router
  import NeuMapWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_user
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NeuMapWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/area", AreaController
    resources "/building", BuildingController
    resources "/service", ServiceController
    resources "/tag", TagController
    resources "/favorite", FavoriteController
    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
    post "/search", SearchController, :index
    get "/search", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NeuMapWeb do
  #   pipe_through :api
  # end
end
