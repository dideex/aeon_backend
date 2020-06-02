defmodule Backend.Resolvers.Post do
  # import Ecto.Query, only: [from: 2]
  alias Backend.Post

  # Queries
  def by_user_id(%{user_id: user_id}, %{context: %{current_user: user}}) do
    posts =
      user_id
      |> Post.get()
      |> Enum.map(& add_timestamp/1)
    {:ok, posts}
  end

  defp add_timestamp(%{created_at: created_at} = post) do
    IO.inspect(created_at, label: :created)
    timestamp =
      created_at
      |> DateTime.from_naive!("Etc/UTC")
      |> DateTime.to_unix()
    Map.put(post, :created, timestamp)
  end
end
