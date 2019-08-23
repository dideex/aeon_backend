defmodule Backend.User.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title body user)a
  @optional_fields ~w(views)a

  schema "posts" do
    field(:title, :string)
    field(:body, :string)
    field(:views, :integer, default: 0)

    timestamps(inserted_at: :created_at)

    belongs_to(:user, Backend.User)
    many_to_many(:likes, Backend.User, join_through: "post_likes")
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
