defmodule Chat do
  def join(chat) do
    chat = GenServer.call(chat, :subscribe)
    { :ok, chat }
  end

  def new_message({chat, author, message}) do
    chat = GenServer.call(chat, { :new_message, author, message })
    { :ok, chat }
  end
end
