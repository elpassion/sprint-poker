defmodule PlanningPoker.Router do
  use PlanningPoker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  scope "/", PlanningPoker do
    pipe_through :browser

    get "/", PageController, :index
    get "/:anything", PageController, :index
    get "/games/:anything", PageController, :index
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugCors, origins: ["*"]
  end

  scope "/api", PlanningPoker do
    pipe_through :api

    resources "rooms", RoomController, only: [:create]
    options "/rooms*anything", RoomController, :options
  end
end
