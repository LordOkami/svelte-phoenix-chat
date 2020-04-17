defmodule GatChat.Player do
  @moduledoc """
  """
  @derive {Jason.Encoder, only: [:id, :username, :position, :life]}
  defstruct(
    id: 0,
    username: "",
    life: 1,
    position: %{
      x: 0,
      y: 0
    },
    skin: 1,
    animation: 1
  )

  def new(%{username: username}) do
    %__MODULE__{id: generate_id(), username: username}
  end

  def move(%GatChat.Player{} = player, position) do
    %{player | position: position}
  end

  def generate_id() do
    UUID.uuid4()
  end
end
