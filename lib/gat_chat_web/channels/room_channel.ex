defmodule GatChatWeb.RoomChannel do
  use GatChatWeb, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("shout", payload, socket) do
    GatChat.Message.changeset(%GatChat.Message{}, payload) |> GatChat.Repo.insert  
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    GatChat.Message.get_messages()
    |> Enum.each(fn msg -> push(socket, "shout", %{
        name: msg.name,
        message: msg.message,
      }) end)
    {:noreply, socket} # :noreply
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
