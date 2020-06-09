defmodule Backend.Resolvers.Chat do
  alias Backend.Chat

  # Queries
  def all_messages(_, %{context: %{current_user: user}}) do
    posts =
      user.id
      |> Chat.Message.get()
      |> Enum.map(&add_timestamp/1)

    {:ok, posts}
  end

  def topics(_, %{context: %{current_user: user}}) do
    chats =
      user.id
      |> Chat.get()
      |> Enum.map(&add_timestamp/1)

    {:ok, chats}
  end

  defp add_timestamp(%{created_at: created_at} = post) do
    timestamp =
      created_at
      |> DateTime.from_naive!("Etc/UTC")
      |> DateTime.to_unix()

    Map.put(post, :created, timestamp)
  end
end
