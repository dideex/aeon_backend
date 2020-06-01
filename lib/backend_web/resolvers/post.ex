defmodule Backend.Resolvers.Post do
  # import Ecto.Query, only: [from: 2]
  alias Backend.Post

  # Queries
  def by_user_id(%{user_id: user_id}, %{context: %{current_user: user}}) do
    {:ok, Post.get(user_id)}
  end
end
