defmodule PlanningPoker.RoomView do
  use PlanningPoker.Web, :view

  def render("create.json", %{room: room}) do
    room
  end
end
