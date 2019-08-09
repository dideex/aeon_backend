defmodule Backend.User.FriendInvite do
  use Ecto.Schema
  require Ecto.Query

  {:ok, now} = DateTime.now("Etc/UTC")

  schema "friend_invites" do
    field(:date, :date, default: now)

    belongs_to(:user, Backend.User)
    has_one(:sender, Backend.User)
  end
end
