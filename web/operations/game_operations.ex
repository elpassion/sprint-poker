defmodule SprintPoker.GameOperations do
  alias SprintPoker.Repo
  alias SprintPoker.Game
  alias SprintPoker.Deck
  alias SprintPoker.StateOperations

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
    end
    game
  end

  def find(nil), do: :no_id
  def find(game_id) do
    case Game.get(game_id) do
      nil -> :error
      game -> game |> Repo.preload([:owner, :deck])
    end
  end
end
