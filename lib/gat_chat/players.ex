defmodule GatChat.Players do
  @moduledoc """
  """

  alias GatChat.Player

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add(player) do
    Agent.update(__MODULE__, fn(players) -> [player | players] end)
    player
  end

  def reset() do
    Agent.update(__MODULE__, fn(_) -> [] end)
  end

  def all() do
    Agent.get(__MODULE__, fn(players) -> players end)
  end



  def get(id) do
    Agent.get(__MODULE__, fn(players) -> Enum.find(players, fn(player) -> player.id == id end) end)
  end

  def remove(id) do
    Agent.update(__MODULE__, fn(players) -> Enum.filter(players, fn(player) -> player.id != id end) end)
  end

  def count() do
    Enum.count(all())
  end

  def move(id, position) do
    Agent.update(__MODULE__, fn(players) -> sync_and_move(players, id, position) end)
  end


  defp sync_and_move(players, id_to_move, position) do
    Enum.map(players, fn(player) ->
      if player.id == id_to_move do
        Player.move(player, position)
      else
        player
      end
    end)
  end

end
