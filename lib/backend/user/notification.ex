defmodule Backend.User.Notification do
  use Ecto.Schema
  require Ecto.Query

  schema "posts" do
    field(:unread, :boolean, default: false)
    field(:type, :string)
    field(:title, :string)
    field(:body, :string)

    belongs_to(:user, Backend.User)
  end
end
