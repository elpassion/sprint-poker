defmodule PlanningPoker.CreateNewGameTest do
  use ExUnit.Case
  use TucoTuco.DSL

  setup_all do
  #    router = PlanningPoker.Router
    port = PlanningPoker.Endpoint.config(:http)[:port]
    # router.start

    PlanningPoker.Endpoint.start_link()

    {:ok, _} = TucoTuco.start_session :test_browser, :test_session, :firefox
    #    TucoTuco.app_root "http://localhost:#{port}"

    on_exit fn -> TucoTuco.stop end
    :ok
  end

  test "" do
    visit "/"
    click_link "Create Session"
    assert_selector :xpath, "//foo/bar"
  end
end

