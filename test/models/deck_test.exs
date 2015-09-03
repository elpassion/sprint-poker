defmodule PlanningPoker.DeckTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.Deck
  alias PlanningPoker.Repo

  test "don't create empty deck" do
    assert_raise Postgrex.Error, fn ->
      %Deck{} |> Repo.insert!
    end
  end

  test "don't create deck without name" do
    assert_raise Postgrex.Error, fn ->
      %Deck{
        cards: []
      } |> Repo.insert!
    end
  end

  test "create deck with name and cards" do
    deck = %Deck{
      name: "sample name",
      cards: []
    } |> Repo.insert!

    assert deck
  end

  test "empty deck is not valid" do
    changeset = %Deck{} |> Deck.changeset(%{})
    refute changeset.valid?
  end

  test "deck without name with changeset is not valid" do
    changeset = %Deck{} |> Deck.changeset(%{cards: []})
    refute changeset.valid?
  end

  test "deck with name and cards is valid" do
    changeset = %Deck{} |> Deck.changeset(%{name: "sample name", cards: []})
    assert changeset.valid?
  end
end
