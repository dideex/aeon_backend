defmodule Backend.Chat.ChatInvite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_invites" do
    belongs_to(:user, Backend.User)
    belongs_to(:chat, Backend.User.ChatInvite)
    has_one(:sender, Backend.User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(invite, attrs) do
    invite
    |> assoc_constraint(:user)
  end
end
