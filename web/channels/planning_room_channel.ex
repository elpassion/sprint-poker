defmodule PlanningPoker.PlanningRoomChannel do
  use PlanningPoker.Web, :channel
  alias PlanningPoker.Room
  alias PlanningPoker.Participant
  alias PlanningPoker.Ticket
  alias PlanningPokerApi.RoomParticipants

  def join("planning:room:" <> uuid, payload, socket) do
    room = get_room_with_associations(uuid, [:participants])

    case room do
      %Room{} ->
        participant = insert_unless_exists(room, payload)

        case participant do
          %Participant{} ->
            send(self, {:new_participant, participant})
            {:ok, socket}

          _ -> {:error, %{reason: "unauthorized"}}
        end

      _ -> {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info({:new_participant, participant}, socket) do
    "planning:room:" <> room_uuid = socket.topic
    push socket, "session", %{participant: participant}
    sync(socket, room_uuid)
    {:noreply, socket}
  end

  def handle_in("create_ticket", %{"userUUID" => userUUID, "ticket" => ticket}, socket) do
    participant = Repo.get_by!(Participant, %{uuid: userUUID})
    "planning:room:" <> room_uuid = socket.topic
    ticket = Repo.insert!(%Ticket{room_id: room_uuid, owner: participant, name: ticket["name"]})
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

  def get_room_with_associations(uuid, associations \\ [:participants, :tickets, :room_participants]) do
    Repo.get_by!(Room, %{uuid: uuid}) |> Repo.preload(associations)
  end

  def insert_unless_exists(room, %{"uuid" => uuid}) do
    participant = Repo.get_by!(Participant, %{uuid: uuid})
    unless Enum.member?(room.participants, participant) do
      Repo.insert!(%RoomParticipants{room_id: room.id, participant_id: participant.id})
    end
    participant
  end

  def insert_unless_exists(room, _) do
    participant = Repo.insert!(%Participant{name: PlanningPokerApi.RandomGenerator.name()})
    Repo.insert!(%RoomParticipants{room_id: room.id, participant_id: participant.id})
    participant
  end

  def sync(socket, uuid) do
    broadcast socket, "sync", %{room: get_room_with_associations(uuid)}
  end
end
