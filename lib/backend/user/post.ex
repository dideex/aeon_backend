defmodule Backend.User.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title body)a
  @optional_fields ~w(views)a

  schema "posts" do
    field(:title, :string)
    field(:body, :string)
    field(:views, :integer, default: 0)

    timestamps(inserted_at: :created_at)

    belongs_to(:user, Backend.User)
    has_many(:likes, Backend.User)
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
