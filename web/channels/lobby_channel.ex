defmodule PlanningPoker.LobbyChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.Game

  def join("lobby", message, socket) do
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def handle_info({:after_join, message}, socket) do
    user = Repo.get(User, socket.assigns.user_id)
    socket |> push "user", %{id: user.id, auth_token: user.auth_token, name: user.name}
    socket |> push "scales", get_scales
    {:noreply, socket}
  end

  def handle_in("update_user", message, socket) do
    user = %{Repo.get(User, socket.assigns.user_id) | name: message["name"]} |> Repo.update!

    socket |> push "user", user
    {:noreply, socket}
  end

  def handle_in("create_game", message, socket) do
    socket |> push "game", Repo.insert!(
      %Game{
        name: message["name"],
        owner_id: Repo.get(User, socket.assigns.user_id).id
      }
    ) |> Repo.preload([:owner])

    {:noreply, socket}
  end

  defp get_scales do
    %{
      "Fibbonacci" => 0,
      "Other" => 999
    }
  end

end
