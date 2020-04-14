defmodule GatChatWeb.RoomChannel do
  use GatChatWeb, :channel
  alias GatChatWeb.Presence
  alias GatChat.Player
  def join("room:lobby", _, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("shout", payload, socket) do
    GatChat.Message.changeset(%GatChat.Message{}, payload) |> GatChat.Repo.insert()
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    # Instantiate presence for new connection
    user_id = socket.assigns.user_id
    IO.inspect(socket)
    player = Player.new(%{id: socket.id, username: user_id})
    IO.inspect(player)

    {:ok, _} =
      Presence.track(socket, socket.assigns.user_id, %{
        online_at: :os.system_time(:milli_seconds),
        device: "browser"
      })

    push(socket, "presence_state", Presence.list(socket))

    # Fetch lasts messages and send them with socket
    GatChat.Message.get_messages()
    |> Enum.each(fn msg ->
      push(socket, "shout", %{
        name: msg.name,
        message: msg.message
      })
    end)

    # :noreply
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
