defmodule SprintPoker.TicketOperations do
  alias SprintPoker.Repo
  alias SprintPoker.Ticket

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
    case Repo.get(Ticket, params["id"]) do
      nil -> :nothing
      ticket -> ticket |> Repo.delete!
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
