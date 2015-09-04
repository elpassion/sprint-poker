defmodule PlanningPoker.JoinGameTest do
  use PlanningPoker.BrowserCase

  setup do
    visit "/"
    fill_in "game_name", "Test Game"
    fill_in "user_name", "Test Owner User"
    select "T-Shirts (S, M, L, XXL)", from: "game_deck"
    click_button "Start Session"

    game_url = retry fn ->
      input_value "game_url"
    end

    {:ok, game_url: game_url}
  end

  test "join page has game name", context do
    visit context[:game_url]
    assert Page.has_text? "Join session ?"

    game_name = input_value "game_name"

    assert game_name == "Test Game"
  end

  test "join page has session owner", context do
    visit context[:game_url]
    assert Page.has_text? "Join session ?"

    owner_name = input_value "game_owner"

    assert owner_name == "Test Owner User"
  end

  test "join page has session deck", context do
    visit context[:game_url]
    assert Page.has_text? "Join session ?"

    deck_name = input_value "game_deck"

    assert deck_name == "2"
  end

  test "join page has user name", context do
    visit context[:game_url]
    assert Page.has_text? "Join session ?"

    user_name = input_value "user_name"

    assert user_name == "Test Owner User"
  end

  test "can join game", context do
    visit context[:game_url]
    assert Page.has_text? "Join session ?"
    click_button "Join Session"
    Page.has_text? "Test Game"

    refute Page.has_text? "Session Title Cant be blank"
    refute Page.has_text? "Your Nickname Cant be blank"
    assert Page.has_text? "Test Game"
    assert Page.has_text? "Test Owner User"
    assert Finder.find(:id, "game_url")
  end


end
