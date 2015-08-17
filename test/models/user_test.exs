defmodule PlanningPoker.UserTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.User
  alias PlanningPoker.Repo

  test "creating empty user generate auth_token" do
    user = %User{} |> Repo.insert!
    assert user.auth_token
  end

end

