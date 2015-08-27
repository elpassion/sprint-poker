defmodule PlanningPoker.UserOperations do
  alias PlanningPoker.GameUser
  alias PlanningPoker.Repo
  alias PlanningPoker.User

  def connect(user, game) do
    unless Repo.get_by(GameUser, game_id: game.id, user_id: user.id) do
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
  end

  def disconnect(user, game) do
    game_user = Repo.get_by(GameUser, game_id: game.id, user_id: user.id)

    if game_user do
      game_user |> Repo.delete!
    end
  end

  def authorize(nil) do
    Repo.insert!(%User{})
  end

  def authorize(auth_token) do
    Repo.get_by(User, auth_token: auth_token) || authorize(nil)
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
end
