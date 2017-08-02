defmodule SprintPoker.UserTest do
  use SprintPoker.DataCase

  alias SprintPoker.Repo
  alias SprintPoker.Repo.User

  test "creating empty user generate auth_token" do
    user = %User{} |> Repo.insert!
    assert user.auth_token
  end

end
