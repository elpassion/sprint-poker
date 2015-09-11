defmodule SprintPoker.UserTest do
  use SprintPoker.ModelCase

  alias SprintPoker.User
  alias SprintPoker.Repo

  test "creating empty user generate auth_token" do
    user = %User{} |> Repo.insert!
    assert user.auth_token
  end

end

