defmodule Backend.Repo.User.PhotoLike do
  use Ecto.Schema

  schema "photo_likes" do
    belongs_to(:photo, Backend.User.Photo)
    belongs_to(:user, Backend.User)

    timestamps(inserted_at: :created_at)
  end
end
