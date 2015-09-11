defmodule SprintPoker.StateOperations do
  alias SprintPoker.Repo
  alias SprintPoker.State

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
    unless state.name == "review" do
      new_votes = for {key, value} <- state.votes, into: %{} do
        if key == current_user.id do
          {key,  value}
        else
          {key, "voted"}
        end
      end

      state = %{state | votes: new_votes}
    end
    state
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
end
