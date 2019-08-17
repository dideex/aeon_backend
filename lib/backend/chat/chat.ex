defmodule Backend.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(group name)a
  @optional_fields ~w(image)a

  schema "chats" do
    field(:group, :boolean, default: false)
    field(:name, :string)
    field(:image, :string)

    belongs_to(:user, Backend.User)
    belongs_to(:chat, Backend.Chat)
    has_many(:members, Backend.User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(chat, attrs) do
    chat
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
