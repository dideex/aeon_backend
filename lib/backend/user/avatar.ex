defmodule Backend.User.Avatar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "avatars" do
    field(:title, :string)
    field(:url, :string)
    belongs_to(:user, Backend.User)

    timestamps(inserted_at: :created_at)
  end
end
