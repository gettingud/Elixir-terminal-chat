defmodule Chat.Channel do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: node())
  end

  def init(_) do
    { :ok, self() }
  end

  def handle_call(:subscribe, _from, channel) do
    { :reply, node(), channel }
  end

  def handle_call({ :new_message, author, message }, _from, channel) do
    Enum.each(Node.list, fn subscriber ->
      publish_message(subscriber, { author, message })
    end)
    { :reply, node(), channel }
  end

  defp publish_message(subscriber, {author, _message}) when author == subscriber do
    nil
  end

  defp publish_message(subscriber, {author, message}) do
    IO.puts(:global.whereis_name(subscriber), "#{author}: #{message}")
  end
end
