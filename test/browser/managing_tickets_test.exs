defmodule PlanningPoker.JoinGameTest do
  use PlanningPoker.BrowserCase

  @new_ticket_xpath "//input[@name='new_ticket']"

  setup do
    visit "/"
    fill_in "game_name", "Test Game"
    fill_in "user_name", "Test Owner User"
    select "T-Shirts (S, M, L, XXL)", from: "game_deck"
    click_button "Start Session"
    Page.has_text? "SESSION NAME:"
    :ok
  end

  test "owner can add a ticket" do
    fill_in "new_ticket", "Ticket #1"
    click_button "CREATE"
    assert Page.has_xpath? "//input[@value='Ticket #1']"
  end

  test "owner can delete a ticket" do
    fill_in "new_ticket", "Ticket #1"
    click_button "CREATE"
    assert Page.has_xpath? "//input[@value='Ticket #1']"
    click_button "DELETE"
    refute Page.has_xpath? "//input[@value='Ticket #1']"
  end

end
