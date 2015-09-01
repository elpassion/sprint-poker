defmodule PlanningPoker.JoinGameTest do
  use PlanningPoker.BrowserCase

  @game_url_xpath   "//input[@name='game_url']"
  @game_name_xpath  "//input[@name='game_name']"
  @game_owner_xpath "//input[@name='game_owner']"
  @game_user_xpath  "//input[@name='user_name']"
  @game_deck_xpath  "//select[@name='game_deck']"

  setup do
    visit "/"
    fill_in "game_name", "Test Game"
    fill_in "user_name", "Test Owner User"
    select "T-Shirts (S, M, L, XXL)", from: "game_deck"
    click_button "Start Session"

    Page.has_xpath? @game_url_xpath

    room_url = Element.attribute(
      Finder.find(:xpath, @game_url_xpath),
      :value
    )

    {:ok, room_url: room_url}
  end

  test "join page has session name", context do
    visit context[:room_url]
    assert Page.has_text? "Join session ?"
    assert Page.has_xpath? @game_name_xpath

    session_name = Element.attribute(
      Finder.find(:xpath, @game_name_xpath),
      :value
    )

    assert session_name == "Test Game"
  end

  test "join page has session owner", context do
    visit context[:room_url]
    assert Page.has_text? "Join session ?"
    assert Page.has_xpath? @game_owner_xpath

    owner_name = Element.attribute(
      Finder.find(:xpath, @game_owner_xpath),
      :value
    )

    assert owner_name == "Test Owner User"
  end

  test "join page has session deck", context do
    visit context[:room_url]
    assert Page.has_text? "Join session ?"
    assert Page.has_xpath? @game_deck_xpath

    deck_name = Element.attribute(
      Finder.find(:xpath, @game_deck_xpath),
      :value
    )

    assert deck_name == "2"
  end

  test "join page has user owner", context do
    visit context[:room_url]
    assert Page.has_text? "Join session ?"
    assert Page.has_xpath? @game_user_xpath

    user_name = Element.attribute(
      Finder.find(:xpath, @game_user_xpath),
      :value
    )

    assert user_name == "Test Owner User"
  end

  test "can join game", context do
    visit context[:room_url]
    assert Page.has_text? "Join session ?"
    click_button "Join Session"
    Page.has_text? "Test Game"

    refute Page.has_text? "Session Title Cant be blank"
    refute Page.has_text? "Your Nickname Cant be blank"
    assert Page.has_text? "Test Game"
    assert Page.has_text? "Test Owner User"
  end

end
