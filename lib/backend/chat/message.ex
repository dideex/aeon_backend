defmodule Backend.Chat.Message do

  alias Backend.Repo
  alias Backend.Repo.Chat.Message

  import Ecto.Query

  def get(id) do
    Message
    |> where([c], c.sender_id == ^id)
    |> preload(:sender)
    |> Repo.all()
  end

  def get_all do
    Post
  end
end
