defmodule Backend.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(body)a
  @optional_fields ~w(unread)a

  schema "messages" do
    field(:body, :string)
    field(:unread, :boolean, default: true)

    belongs_to(:user, Backend.User)
    has_one(:sender, Backend.User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
