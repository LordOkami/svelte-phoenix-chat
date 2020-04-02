defmodule GatChat.Repo do
  use Ecto.Repo,
    otp_app: :gat_chat,
    adapter: Ecto.Adapters.Postgres
end
