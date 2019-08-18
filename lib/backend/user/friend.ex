defmodule Backend.User.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friends" do
    belongs_to(:user1, Backend.User)
    belongs_to(:user2, Backend.User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(friend) do
    friend
    |> assoc_constraint(:user)
  end
end
