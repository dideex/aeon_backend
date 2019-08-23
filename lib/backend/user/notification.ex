defmodule Backend.User.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title type body user)a
  @optional_fields ~w(unread)a

  schema "posts" do
    field(:title, :string)
    field(:body, :string)
    field(:type, :string)
    field(:unread, :boolean, default: false)

    belongs_to(:user, Backend.User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(notification, attrs) do
    notification
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
