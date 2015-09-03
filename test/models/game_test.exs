defmodule PlanningPoker.GameTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.Game
  alias PlanningPoker.User
  alias PlanningPoker.Deck
  alias PlanningPoker.Repo

  test "don't create empty game" do
    assert_raise Postgrex.Error, fn ->
      %Game{} |> Repo.insert!
    end
  end

  test "don't create game without name" do
    user = %User{} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!

    assert_raise Postgrex.Error, fn ->
      %Game{
        owner_id: user.id,
        deck_id: deck.id
      } |> Repo.insert!
    end
  end

  test "don't create game without owner" do
    deck = %Deck{name: "test deck"} |> Repo.insert!

    assert_raise Postgrex.Error, fn ->
      %Game{
        name: "sample name",
        deck_id: deck.id
      } |> Repo.insert!
    end
  end

  test "don't create game without deck" do
    user = %User{} |> Repo.insert!

    assert_raise Postgrex.Error, fn ->
      %Game{
        name: "sample name",
        owner_id: user.id
      } |> Repo.insert!
    end
  end

  test "create game with name and onwer_id" do
    user = %User{} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!

    game = %Game{
      name: "sample name",
      owner_id: user.id,
      deck_id: deck.id
    } |> Repo.insert! |> Repo.preload([:owner, :deck])

    assert game
    assert game.owner == user
    assert game.deck == deck
  end

  test "empty game changeset is not valid" do
    changeset = %Game{} |> Game.changeset(%{})

    refute changeset.valid?
  end

  test "game changeset without name is not valid" do
    user = %User{} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!
    changeset = %Game{} |> Game.changeset(%{
      owner_id: user.id,
      deck_id: deck.id
    })

    refute changeset.valid?
  end

  test "game changeset without owner is not valid" do
    deck = %Deck{name: "test deck"} |> Repo.insert!
    changeset = %Game{} |> Game.changeset(%{
      name: "sample name",
      deck_id: deck.id
    })

    refute changeset.valid?
  end

  test "game changeset without deck is not valid" do
    user = %User{} |> Repo.insert!
    changeset = %Game{} |> Game.changeset(%{
      name: "sample name",
      owner_id: user.id
    })

    refute changeset.valid?
  end

  test "game changeset with name and onwer_id is valid" do
    user = %User{} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!

    changeset = %Game{} |> Game.changeset(%{
      name: "sample name",
      owner_id: user.id,
      deck_id: deck.id
    })

    assert changeset.valid?
  end
end
