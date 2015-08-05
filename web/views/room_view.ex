defmodule PlanningPoker.RoomView do
  use PlanningPoker.Web, :view

  def render("create.json", %{room: room}) do
    IO.inspect(room)
    room
  end
end
