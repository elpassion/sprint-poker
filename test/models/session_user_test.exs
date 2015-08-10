defmodule PlanningPoker.SessionUserTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.SessionUser

  @valid_attrs %{session_uuid: "7488a646-e31f-11e4-aace-600308960662", user_uuid: "7488a646-e31f-11e4-aace-600308960662"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SessionUser.changeset(%SessionUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SessionUser.changeset(%SessionUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
