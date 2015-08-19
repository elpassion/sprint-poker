defmodule PlanningPoker.Router do
  use PlanningPoker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", PlanningPoker do
    pipe_through :browser

    get "/*anything", PageController, :index
  end
end
