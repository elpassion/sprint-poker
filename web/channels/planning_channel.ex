defmodule PlanningPoker.PlanningChannel do
  use PlanningPoker.Web, :channel
  alias PlanningPoker.Room
  alias PlanningPoker.Participant
  alias PlanningPoker.Ticket
  alias PlanningPoker.RoomParticipants

  def join("planning:room:" <> uuid, payload, socket) do
    room = get_room_with_associations(uuid, [:participants])
    participant = insert_unless_exists(room, payload)
    send(self, {:new_participant, participant})
    {:ok, socket}
  end

  def handle_info({:new_participant, participant}, socket) do
    "planning:room:" <> room_uuid = socket.topic
    push socket, "session", %{participant: participant}
    sync(socket, room_uuid)
    {:noreply, socket}
  end

  def handle_in("create_ticket", %{"userUUID" => user_uuid, "ticket" => ticket}, socket) do
    participant = Repo.get_by!(Participant, %{uuid: user_uuid})
    "planning:room:" <> room_uuid = socket.topic
    room = Repo.get_by!(Room, %{uuid: room_uuid})
    ticket = Repo.insert!(%Ticket{room_id: room.id, owner: participant, name: ticket["name"]})
    sync(socket, room_uuid)
    {:noreply, socket}
  end

  def handle_in("delete_ticket", payload, socket) do
    ticket = Repo.get!(Ticket, payload["ticket"]["id"])
    Repo.delete!(ticket)
    "planning:room:" <> room_uuid = socket.topic
    sync(socket, room_uuid)
    {:noreply, socket}
  end

  def handle_in("update_ticket", payload, socket) do
    ticket = Repo.get!(Ticket, payload["ticket"]["id"])
    Repo.update!(%{ticket | name: payload["ticket"]["name"]})
    "planning:room:" <> room_uuid = socket.topic
    sync(socket, room_uuid)
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  defp get_room_with_associations(uuid, associations \\ [:participants, :tickets, :room_participants]) do
    Repo.get_by!(Room, %{uuid: uuid}) |> Repo.preload(associations)
  end

  defp insert_unless_exists(room, %{"uuid" => uuid}) do
    participant = Repo.get_by!(Participant, %{uuid: uuid})
    unless participant in room.participants do
      Repo.insert!(%RoomParticipants{room_id: room.id, participant_id: participant.id})
    end
    participant
  end

  defp insert_unless_exists(room, _) do
    participant = Repo.insert!(%Participant{name: PlanningPoker.RandomGenerator.name()})
    Repo.insert!(%RoomParticipants{room_id: room.id, participant_id: participant.id})
    participant
  end

  defp sync(socket, uuid) do
    broadcast socket, "sync", %{room: get_room_with_associations(uuid)}
  end
end
