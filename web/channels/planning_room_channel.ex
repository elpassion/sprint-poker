defmodule PlanningPoker.PlanningRoomChannel do
  use PlanningPoker.Web, :channel
  alias PlanningPoker.Room
  alias PlanningPoker.Participant
  alias PlanningPoker.Ticket

  def join("planning:room:" <> room_uuid, payload, socket) do
    room = get_room(room_uuid)

    case room do
      %Room{} ->
        participant = insert_unless_exists(room, payload)

        case participant do
          %Participant{} ->
            if is_nil(room.owner_id) do
              Repo.update!(%{room | owner_id: participant.id})
            end

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
    participant = get_participant(userUUID)
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

  def handle_in("final_estimate_ticket", %{ticket: ticket, participant: participant}, socket) do
    broadcast socket, "ticket_final_estimated", %{ticket: ticket}
    {:noreply, socket}
  end

  def handle_in("edit_room", %{room: room}, socket) do
    broadcast socket, "room_edited", %{room: room}
    {:noreply, socket}
  end

  def handle_in("leaving", %{participant: participant}, socket) do
    broadcast socket, "participant_leaving", %{id: participant.id}
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def get_room(uuid) do
    Repo.get(Room, uuid)
  end

  def get_participant(uuid) do
    Repo.get_by!(Participant, %{uuid: uuid})
  end

  def insert_unless_exists(_, %{"uuid" => uuid}) do
    get_participant(uuid)
  end

  def insert_unless_exists(room, _) do
    Repo.insert!(%Participant{name: PlanningPoker.RandomGenerator.name(), room_id: room.id})
  end

  def sync(socket, room_uuid) do
    broadcast socket, "sync", %{room: get_room(room_uuid) |> Repo.preload([:owner, :participants, :tickets])}
  end
end
