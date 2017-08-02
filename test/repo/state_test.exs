defmodule SprintPoker.StateTest do
  use SprintPoker.DataCase

  alias SprintPoker.Repo.User
  alias SprintPoker.Repo.Deck
  alias SprintPoker.Repo.Game
  alias SprintPoker.Repo.State


  @test_user %User{}
  @test_deck %Deck{name: "test deck", cards: []}

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
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{
      name: "sample name",
      owner_id: user.id,
      deck_id: deck.id
    } |> Repo.insert!

    changeset = %State{} |> State.changeset(%{name: "none", game_id: game.id})

    assert changeset.valid?
  end
end
