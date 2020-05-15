defmodule Backend.Repo.User.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title body)a
  @optional_fields ~w(views photo author_id)a

  schema "posts" do
    field(:title, :string)
    field(:body, :string)
    field(:photo, :string)
    field(:views, :integer, default: 0)

    timestamps(inserted_at: :created_at)

    belongs_to(:author, Backend.User)
    many_to_many(:likes, Backend.User, join_through: "post_likes")
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:author)
  end
end
