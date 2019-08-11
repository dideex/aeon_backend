defmodule Backend.User.FriendInvite do
  use Ecto.Schema

  schema "friend_invites" do
    timestamps()

    # belongs_to(:user, Backend.User)
    # has_one(:sender, Backend.User)
  end
end
