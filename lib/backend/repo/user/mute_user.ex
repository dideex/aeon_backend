defmodule Backend.Repo.User.MuteUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Repo.User

  @required_fields ~w(mute_user_id)a
  @optional_fields ~w(user_id)a

  schema "mute_users" do
    belongs_to(:user, User)
    field(:mute_user_id, :integer)

    timestamps(inserted_at: :created_at)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
