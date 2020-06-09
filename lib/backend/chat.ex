defmodule Backend.Chat do

  alias Backend.Repo.Chat

  import Ecto.Query, only: [from: 2]

  def get(id) do
    Backend.Repo.all(from p in Chat, where: p.owner_id == ^id)
  end

  def get_all do
    Chat
  end
end
