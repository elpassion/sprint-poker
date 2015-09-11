defmodule SprintPoker.GameUserOperations do
  alias SprintPoker.Repo
  alias SprintPoker.GameUser

  def create(game, user) do
    changeset = GameUser.changeset(%GameUser{}, %{
      game_id: game.id,
      user_id: user.id
    })

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.insert!
    end
  end

  def update_state(game_user, state) do
    changeset = GameUser.changeset(game_user, %{state: state})

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.update!
    end

  end
end
