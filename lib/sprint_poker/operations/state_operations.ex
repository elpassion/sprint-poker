defmodule SprintPoker.StateOperations do
  @moduledoc """
  Game state related operations
  """

  alias SprintPoker.Repo
  alias SprintPoker.Repo.State

  def create(game) do
    changeset = State.changeset(%State{}, %{name: "none", game_id: game.id})

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.insert!
    end
  end

  def hide_votes(state, current_user) do
    if state.name == "review" do
      state
    else
      new_votes = for {key, value} <- state.votes, into: %{} do
        if key == current_user.id do
          {key,  value}
        else
          {key, "✓"}
        end
      end

      %{state | votes: new_votes}
    end
  end

  def update(state, params) do
    changeset = State.changeset(state, params)

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.update!
    end
  end

  def preload(data) do
    data |> Repo.preload([:state])
  end
end
