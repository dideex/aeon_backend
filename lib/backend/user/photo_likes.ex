defmodule Backend.User.PhotoLikes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photo_likes" do
    belongs_to(:photo_id, Backend.User.Photo)
    belongs_to(:user_id, Backend.User)
    timestamps(inserted_at: :created_at)
  end
end
