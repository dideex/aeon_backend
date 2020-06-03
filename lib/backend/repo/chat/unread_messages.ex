defmodule Backend.Repo.Chat.Unread do
  alias Backend.Repo.{Chat, User}
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields ~w(user_id message_id)a

  schema "unread_messages" do
    belongs_to(:user, User)
    belongs_to(:message, Chat.Message)
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @optional_fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:message)
  end
end
