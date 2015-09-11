defmodule SprintPoker.PageController do
  use SprintPoker.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
