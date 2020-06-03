defmodule Backend.Repo.User.PhotoLike do
  use Ecto.Schema
  alias Backend.Repo.User

  schema "photo_likes" do
    belongs_to(:photo, User.Photo)
    belongs_to(:user, User)

    timestamps(inserted_at: :created_at)
  end
end
