defmodule Backend.Repo.Chat.Member do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Repo.{Chat, User}

  @optional_fields ~w(user_id chat_id)a

  schema "chat_members" do
    belongs_to(:user, User)
    belongs_to(:chat, Chat)
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, @optional_fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:chat)
  end
end
