defmodule GatChatWeb.PageControllerTest do
  use GatChatWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Chat"
  end
end
