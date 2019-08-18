defmodule Backend.User.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @required_fields ~w(user1 user2)a

  schema "friends" do
    field(:user1, :integer, primary_key: true)
    field(:user2, :integer, primary_key: true)

    timestamps(updated_at: false)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:follow, name: :user_followers_pkey)
  end
end
