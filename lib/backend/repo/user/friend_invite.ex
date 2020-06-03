defmodule Backend.Repo.User.FriendInvite do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields ~w(user_id sender_id)a

  schema "friend_invites" do
    timestamps(inserted_at: :created_at)

    belongs_to(:user, Backend.User)
    field(:sender_id, :integer)
  end

  def changeset(invite, attrs) do
    invite
    |> cast(attrs, @optional_fields)
    |> assoc_constraint(:user)
  end
end
