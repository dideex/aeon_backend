defmodule Backend.Chat.Message do
  use Ecto.Schema
  require Ecto.Query


  schema "messages" do
    field(:body, :string)
    field(:unread, :boolean, default: true)
    timestamps()

    belongs_to(:user, Backend.User)
    has_one(:sender, Backend.User)
  end
end
