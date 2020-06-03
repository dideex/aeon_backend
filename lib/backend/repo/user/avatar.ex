defmodule Backend.Repo.User.Avatar do
  alias Backend.Repo.User
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title url user_id)a

  schema "avatars" do
    field(:title, :string)
    field(:url, :string)
    belongs_to(:user, User)

    timestamps(inserted_at: :created_at)
  end

  def changeset(avatar, attrs) do
    avatar
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
