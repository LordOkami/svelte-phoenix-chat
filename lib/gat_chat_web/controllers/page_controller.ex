defmodule GatChatWeb.PageController do
  use GatChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
