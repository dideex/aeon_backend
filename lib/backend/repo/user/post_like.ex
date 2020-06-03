defmodule Backend.Repo.User.PostLike do
  alias Backend.Repo.User

  use Ecto.Schema

  schema "post_likes" do
    belongs_to(:user, User)
    belongs_to(:post, User.Post)
  end
end
