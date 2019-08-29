defmodule Backend.User.PostLike do
  use Ecto.Schema

  schema "post_likes" do
    belongs_to(:user, Backend.User)
    belongs_to(:post, Backend.User.Post)
  end
end
