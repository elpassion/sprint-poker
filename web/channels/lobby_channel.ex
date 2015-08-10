defmodule PlanningPoker.LobbyChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.RandomGenerator

  def join("lobby", message, socket) do
    send(self, {:hello, message})
    {:ok, socket}
  end

  def handle_info({:hello, message}, socket) do
    socket |> push "user", get_user(message)
    socket |> push "scales", get_scales
    {:noreply, socket}
  end

  defp get_user(%{"uuid" => uuid}) do
    Repo.get_by!(User, %{uuid: uuid}) || get_user(nil)
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
      "Fibbonacci" => "",
      "Other" => ""
    }
  end

end
