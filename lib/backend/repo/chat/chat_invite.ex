defmodule Backend.Repo.Chat.Invite do
  alias Backend.Repo.{Chat, User}
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields ~w(user_id sender_id chat_id)a

  schema "chat_invites" do
    belongs_to(:user, User)
    belongs_to(:chat, Chat)
    field(:sender_id, :integer)

    timestamps(inserted_at: :created_at)
  end

  def changeset(invites, attrs) do
    invites
    |> cast(attrs, @optional_fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:chat)
  end
end
