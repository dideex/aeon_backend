defmodule Backend.Chat.Message do
  use Ecto.Schema
  require Ecto.Query


  schema "messages" do
    field(:body, :string)
    field(:unread, :boolean, default: true)

    belongs_to(:user, Backend.User)
    has_one(:sender, Backend.User)

    timestamps(inserted_at: :created_at)
  end
end
