defmodule PlanningPoker.RoomView do
  use PlanningPoker.Web, :view

  def render("create.json", %{room: room}) do
    %{title: room.title, id: room.id, owner_id: room.owner_id}
  end
end
