defmodule PlanningPoker.UserTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.User

  @valid_attrs %{name: "some content", uuid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
