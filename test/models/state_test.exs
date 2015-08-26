defmodule PlanningPoker.StateTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.User
  alias PlanningPoker.Deck
  alias PlanningPoker.Game
  alias PlanningPoker.State

  test "empty state changeset is not valid" do
    changeset = %State{} |> State.changeset(%{})

    refute changeset.valid?
  end

  test "state changeset with invalid name is not valid" do
    changeset = %State{} |> State.changeset(%{name: "invalid"})

    refute changeset.valid?
  end

  test "state changeset with valid name without game is not valid" do
    changeset = %State{} |> State.changeset(%{name: "none"})

    refute changeset.valid?
  end

  test "state changeset with valid name with game is valid" do
    user = %User{} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!

    game = %Game{
      name: "sample name",
      owner_id: user.id,
      deck_id: deck.id
    } |> Repo.insert!

    changeset = %State{} |> State.changeset(%{name: "none", game_id: game.id})

    assert changeset.valid?
  end
end
