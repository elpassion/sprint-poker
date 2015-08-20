defmodule PlanningPoker.TicketTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.Ticket

  @valid_attrs %{game_id: "some content", name: "some content", points: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @invalid_attrs)
    refute changeset.valid?
  end
end
