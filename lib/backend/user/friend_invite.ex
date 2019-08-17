defmodule Backend.User.FriendInvite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friend_invites" do
    timestamps(inserted_at: :created_at)

    belongs_to(:user, Backend.User)
    has_one(:sender, Backend.User)
  end

  def changeset(invite, attrs) do
    invite
    |> assoc_constraint(:user)
  end
end
