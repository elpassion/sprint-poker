defmodule Phoenix.ChannelTestWithAssign do
  alias Phoenix.Socket
  alias Phoenix.Socket.Message
  alias Phoenix.Socket.Broadcast
  alias Phoenix.Socket.Reply
  alias Phoenix.Channel.Server

  defmodule NoopSerializer do
    @behaviour Phoenix.Transports.Serializer

    def fastlane!(%Broadcast{} = msg) do
      %Message{
        topic: msg.topic,
        event: msg.event,
        payload: msg.payload
      }
    end

    def encode!(%Reply{} = reply), do: reply
    def encode!(%Message{} = msg), do: msg

    def decode!(message, _opts), do: message
  end

  defmacro subscribe_and_join_with_assigns(channel, topic, assigns, payload \\ Macro.escape(%{})) do
    quote do
      subscribe_and_join_with_assigns(@endpoint, unquote(channel), unquote(topic), unquote(assigns), unquote(payload))
    end
  end

  def subscribe_and_join_with_assigns(endpoint, channel, topic, assigns, payload) do
    unless endpoint do
      raise "module attribute @endpoint not set for subscribe_and_join/4"
    end
    endpoint.subscribe(self(), topic)
    join_with_assigns(endpoint, channel, topic, assigns, payload)
  end

  defmacro join_with_assings(channel, topic, assigns, payload \\ Macro.escape(%{})) do
    quote do
      join_with_assigns(@endpoint, unquote(channel), unquote(topic), unquote(assigns), unquote(payload))
    end
  end

  def join_with_assigns(endpoint, channel, topic, assigns, payload) do
    unless endpoint do
      raise "module attribute @endpoint not set for join/3"
    end

    socket = %Socket{serializer: NoopSerializer,
                     transport_pid: self(),
                     assigns: assigns,
                     endpoint: endpoint,
                     pubsub_server: endpoint.__pubsub_server__(),
                     topic: topic,
                     channel: channel,
                     transport: __MODULE__}

    case Server.join(socket, payload) do
      {:ok, reply, pid} ->
        {:ok, reply, %{socket | channel_pid: pid, joined: true}}
      {:error, _} = error ->
        error
    end
  end

  defmacro __using__(_) do
    quote do
      import Phoenix.ChannelTestWithAssign
    end
  end
end
