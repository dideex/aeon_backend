defmodule Backend.Repo.User.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title url)a

  schema "photos" do
    field(:title, :string)
    field(:url, :string)

    belongs_to(:user, Backend.User)
    many_to_many(:likes, Backend.User, join_through: "photo_likes")

    timestamps(inserted_at: :created_at)
  end

  def changeset(photo, attrs) do
    photo
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
