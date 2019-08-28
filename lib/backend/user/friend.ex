defmodule Backend.User.Friend do
  use Ecto.Schema

  schema "friends" do
    belongs_to(:user_id, Backend.User)
    belongs_to(:friend_id, Backend.User)

    # timestamps(inserted_at: :created_at)
  end
end
