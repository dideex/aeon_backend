defmodule Backend.User.Photo do
  use Ecto.Schema
  require Ecto.Query

  schema "photos" do
    field(:title, :string)
    field(:url, :string)

    belongs_to(:user, Backend.User)
    has_many(:likes, Backend.User)

    timestamps(inserted_at: :created_at)
  end
end
