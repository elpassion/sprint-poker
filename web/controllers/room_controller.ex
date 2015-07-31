defmodule PlanningPoker.RoomController do
  use PlanningPoker.Web, :controller
  alias PlanningPoker.Room
  alias PlanningPoker.Participant

  plug :scrub_params, "room" when action in [:create]

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    if changeset.valid? do
      render(conn, "create.json", room: Repo.insert!(changeset))
    else
      conn
      |> put_status(422)
      |> assign(:room, changeset)
    end
  end
end
