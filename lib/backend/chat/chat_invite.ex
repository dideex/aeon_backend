defmodule Backend.Chat.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields ~w(user_id sender_id chat_id)a

  schema "chat_invites" do
    belongs_to(:user, Backend.User, foreign_key: :chat_invites)
    belongs_to(:chat, Backend.Chat)
    belongs_to(:sender, Backend.User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(invites, attrs) do
    invites
    |> cast(attrs, @optional_fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:chat)
  end
end
