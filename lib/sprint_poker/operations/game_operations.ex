defmodule SprintPoker.GameOperations do
  @moduledoc """
  Game related operations
  """
  import Ecto.Query, only: [from: 2]

  alias SprintPoker.Repo
  alias SprintPoker.Repo.Game
  alias SprintPoker.Repo.Deck
  alias SprintPoker.Repo.User
  alias SprintPoker.Repo.Ticket
  alias SprintPoker.StateOperations

  alias Ecto.UUID

  def create(params, user) do
    changeset = Game.changeset(%Game{}, %{
      name: params["name"],
      owner_id: user.id,
      deck_id: Repo.get!(Deck, params["deck"]["id"]).id
    })

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        game = changeset |> Repo.insert!
        StateOperations.create(game)
        game |> Repo.preload([:owner, :deck])
    end
  end

  def find(nil), do: :no_id
  def find(game_id) do
    case get(game_id) do
      nil -> :error
      game -> game |> Repo.preload([:owner, :deck])
    end
  end

  def preload(data) do
    Repo.preload(data, [
      :owner,
      :deck,
      :state,
      users: from(u in User, order_by: u.name),
      tickets: from(t in Ticket, order_by: t.id)
    ])
  end

  def get(id, opts \\ []) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(Game, id, opts)
      _ -> nil
    end
  end

  def get_decks() do
    Repo.all(Deck)
  end
end
