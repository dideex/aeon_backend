defmodule Backend.User.PhotoLike do
  use Ecto.Schema

  schema "photo_likes" do
    belongs_to(:photo_id, Backend.User.Photo)
    belongs_to(:user_id, Backend.User)

    timestamps(inserted_at: :created_at)
  end
end
