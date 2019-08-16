defmodule Backend.Chat do
  use Ecto.Schema
  require Ecto.Query

  schema "chats" do
    field(:group, :boolean, default: false)
    field(:name, :string)

    belongs_to(:user, Backend.User)
    belongs_to(:chat, Backend.Chat)
    has_many(:members, Backend.User)
  end
end
