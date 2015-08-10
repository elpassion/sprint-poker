defmodule PlanningPoker.LobbyChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.RandomGenerator

  def join("lobby", message, socket) do
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def handle_info({:after_join, message}, socket) do
    socket |> push "user", get_user(message)
    socket |> push "scales", get_scales
    {:noreply, socket}
  end

  def handle_in("update_user", message, socket) do
    user = %{Repo.get_by(User, uuid: message["uuid"]) | name: message["name"]} |> Repo.update!

    socket |> push "user", user
    {:noreply, socket}
  end

  defp get_user(%{"uuid" => uuid}) do
    Repo.get_by(User, %{uuid: uuid}) || get_user(nil)
  end

  defp get_user(_) do
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
