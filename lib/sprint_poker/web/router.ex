defmodule SprintPoker.Web.Router do
  use SprintPoker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SprintPoker.Web do
    pipe_through :api
  end
end
