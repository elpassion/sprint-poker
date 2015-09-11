defmodule SprintPoker.RoomView do
  use SprintPoker.Web, :view

  def render("create.json", %{room: room}) do
    room
  end
end
