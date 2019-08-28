defmodule Backend.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w()a
  @optional_fields ~w(image name group)a

  schema "chats" do
    field(:name, :string, default: "")
    field(:image, :string, default: "")
    field(:group, :boolean, default: false)

    belongs_to(:owner, Backend.User)
    has_many(:messages, Backend.Chat.Message)
    has_many(:chat_invites, Backend.Chat.Invite)
    many_to_many(:members, Backend.User, join_through: "chat_members")

    timestamps(inserted_at: :created_at)
  end

  def changeset(chat, attrs) do
    chat
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:members)
    |> assoc_constraint(:owner)
  end
end
