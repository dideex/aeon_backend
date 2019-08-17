defmodule Backend.Chat.ChatInvite do
  use Ecto.Schema
  require Ecto.Query


  schema "chat_invites" do
    belongs_to(:user, Backend.User)
    belongs_to(:chat, Backend.User.ChatInvite)
    has_one(:sender, Backend.User)

    timestamps(inserted_at: :created_at)
  end
end
