defmodule PlanningPoker.TicketOperations do
  alias PlanningPoker.Repo
  alias PlanningPoker.Ticket

  def create(params, game) do
    changeset = Ticket.changeset(%Ticket{}, %{
      name: params["name"],
      game_id: game.id
    })

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.insert!
    end
  end

  def delete(params) do
    ticket = Repo.get!(Ticket, params["id"])
    if ticket do
      ticket |> Repo.delete!
    end
  end

  def update(ticket, params) do
    changeset = Ticket.changeset(ticket, params)

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.update!
    end
  end
end
