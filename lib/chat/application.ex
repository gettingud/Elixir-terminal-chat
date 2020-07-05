defmodule Chat.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{
        id: Chat.Channel,
        start: { Chat.Channel, :start_link, [] }
      }
    ]

    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
