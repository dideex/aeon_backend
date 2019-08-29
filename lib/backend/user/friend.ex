defmodule Backend.User.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(friend_id)a
  @optional_fields ~w(user_id)a

  schema "friends" do
    belongs_to(:user, Backend.User)
    field(:friend_id, :integer)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:users)
  end
end
