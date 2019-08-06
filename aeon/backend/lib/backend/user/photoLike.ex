defmodule Backend.User.PhotoLike do
  use Ecto.Schema
  require Ecto.Query

  {:ok, now} = DateTime.now("Etc/UTC")

  schema "photoLikes" do
    field :date, :date, default: now

    belongs_to :user, Backend.User
    belongs_to :photo, Backend.User.Photo
  end
end
