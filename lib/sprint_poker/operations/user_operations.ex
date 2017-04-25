defmodule SprintPoker.UserOperations do
  @moduledoc """
  User related operations
  """
  alias SprintPoker.Repo
  alias SprintPoker.Repo.GameUser
  alias SprintPoker.Repo.User
  alias SprintPoker.Repo.Game

  alias SprintPoker.GameUserOperations
  alias Ecto.UUID

  def connect(user_id, game_id) do
    user = Repo.get!(User, user_id)
    game = Repo.get!(Game, game_id)

    case Repo.get_by(GameUser, game_id: game.id, user_id: user.id) do
      nil -> GameUserOperations.create(game, user)
      game_user -> GameUserOperations.update_state(game_user, "connected")
    end
  end

  def disconnect(user_id, game_id) do
    user = Repo.get!(User, user_id)
    game = Repo.get!(Game, game_id)

    game_user = Repo.get_by(GameUser, game_id: game.id, user_id: user.id)
    if game_user do
      GameUserOperations.update_state(game_user, "disconnected")
    end
    game
  end

  def get_or_create(nil) do
    Repo.insert!(%User{})
  end

  def get_or_create(auth_token) do
    case UUID.cast(auth_token) do
      {:ok, auth_token} ->
        Repo.get_by(User, auth_token: auth_token) || get_or_create(nil)
      _ -> get_or_create(nil)
    end
  end

  def update(user, params) do
    changeset = User.changeset(user, %{
      name: params["name"]
    })

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        changeset |> Repo.update!
    end
  end

  def get_by_id(id) do
    Repo.get!(User, id)
  end
end
