defmodule Backend.Chat.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(user sender chat)a

  schema "chat_invites" do
    belongs_to(:user, Backend.User, foreign_key: :chat_invites)
    belongs_to(:sender, Backend.User)
    belongs_to(:chat, Backend.Chat)

    timestamps(inserted_at: :created_at)
  end

  def changeset(invites, attrs) do
    invites
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:chat)
  end
end
