defmodule SprintPoker.Router do
  use SprintPoker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", SprintPoker do
    pipe_through :browser

    get "/*anything", PageController, :index
  end
end
