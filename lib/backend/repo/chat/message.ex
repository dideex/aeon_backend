defmodule Backend.Repo.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(body)a
  @optional_fields ~w(chat_id sender_id)a

  schema "messages" do
    field(:body, :string)

    belongs_to(:sender, Backend.User)
    belongs_to(:chat, Backend.Chat)
    many_to_many(:unread, Backend.User, join_through: "unread_messages")

    timestamps(inserted_at: :created_at)
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:sender)
    |> assoc_constraint(:chat)
  end
end
