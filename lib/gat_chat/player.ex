defmodule GatChat.Player do
  @moduledoc """
  """

  defstruct(
    id: 0,
    username: "",
    life: 1,
    position: %{
      x: 0,
      y: 0
    },
    skin: 1,
    animation: 1,
  )

  def new(%{id: id, username: username}) do
    %__MODULE__{id: id, username: username}
  end

  def render(%__MODULE__{} = player) do
    %{
      "id" => player.id,
      "username" => player.username,
      "position" => player.position,
    }
  end
end
