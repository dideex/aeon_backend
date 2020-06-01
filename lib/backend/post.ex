defmodule Backend.Post do

  alias Backend.Repo.User.Post

  import Ecto.Query, only: [from: 2]

  def get(id) do
    Backend.Repo.all(from p in Post, where: p.author_id == ^id)
  end

  def get_all do
    Post
  end
end
