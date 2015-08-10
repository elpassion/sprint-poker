defmodule PlanningPoker.LobbyChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.Session
  alias PlanningPoker.RandomGenerator

  def join("lobby", message, socket) do
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def handle_info({:after_join, message}, socket) do
    socket |> push "user", get_or_create_user(message)
    socket |> push "scales", get_scales
    {:noreply, socket}
  end

  def handle_in("update_user", message, socket) do
    user = %{Repo.get(User, message["id"]) | name: message["name"]} |> Repo.update!

    socket |> push "user", user
    {:noreply, socket}
  end

  def handle_in("create_session", message, socket) do

    IO.inspect(message)

    socket |> push "session", Repo.insert!(
      %Session{
        name: message["name"],
        owner: Repo.get(User, message["owner"]["id"])
      }
    )
    {:noreply, socket}
  end

  defp get_or_create_user(%{"id" => id}) do
    Repo.get(User, id) || get_or_create_user(nil)
  end

  defp get_or_create_user(_) do
    Repo.insert!(
      %User{
        name: RandomGenerator.name()
      }
    )
  end

  defp get_scales do
    %{
      "Fibbonacci" => 0,
      "Other" => 999
    }
  end

end
