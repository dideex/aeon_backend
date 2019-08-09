defmodule Backend.User.ChatInvite do
  use Ecto.Schema
  require Ecto.Query

  {:ok, now} = DateTime.now("Etc/UTC")

  schema "chat_invites" do
    field(:date, :date, default: now)

    belongs_to(:user, Backend.User)
    belongs_to(:chat, Backend.User.ChatInvite)
    has_one(:sender, Backend.User)
  end
end
