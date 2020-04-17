defmodule GatChatWeb.RoomChannel do
  use GatChatWeb, :channel
  alias GatChatWeb.Presence
  alias GatChat.Player
  alias GatChat.Players

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

  def handle_in("move", %{ "position" => position}, socket) do
    player_id = socket.assigns[:player_id]
    Players.move(player_id, position)

    broadcast(socket, "move", %{
      "player_id": player_id,
      "position": position
    })
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    # Instantiate presence for new connection    
    player = Player.new(%{username: socket.assigns.username})
    Players.add(player)

    socket = assign(socket, :player_id, player.id)

    {:ok, _} =
      Presence.track(socket, player.id, %{
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

  # intercept(["presence_diff"])
  # def handle_out("presence_diff", payload, socket) do
  #   # Only gets triggered at Presence.track, but not when the connection is closed.
  #   leaves = payload.leaves
  #   for {player, meta} <- leaves do
  #     Players.remove(player)
  #   end

  #   {:noreply, socket}
  # endº

  def terminate(reason, socket) do
    Players.remove(socket.assigns[:player_id])
  end
end
