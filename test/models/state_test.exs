defmodule PlanningPoker.StateTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.State

  @valid_attrs %{current_ticket_index: 42, game_id: "some content", votes: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = State.changeset(%State{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = State.changeset(%State{}, @invalid_attrs)
    refute changeset.valid?
  end
end
