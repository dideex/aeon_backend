defmodule Backend.User.Ignore do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @required_fields ~w(user user_ignore)a

  schema "user_ignores" do
    field(:user, :integer, primary_key: true)
    field(:user_ignore, :integer, primary_key: true)

    timestamps(updated_at: false)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
