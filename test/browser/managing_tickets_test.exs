defmodule SprintPoker.ManagingTicketsTest do
  use SprintPoker.BrowserCase

  setup do
    visit "/"
    fill_in "game_name", "Test Game"
    fill_in "user_name", "Test Owner User"
    select "T-Shirts (S, M, L, XXL)", from: "game_deck"
    click_button "Start Session"
    Page.has_text? "SESSION NAME:"
    :ok
  end
end
