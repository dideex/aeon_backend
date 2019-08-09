defmodule Backend.User.Message do
  use Ecto.Schema
  require Ecto.Query

  {:ok, now} = DateTime.now("Etc/UTC")

  schema "messages" do
    field(:body, :string)
    field(:unread, :boolean, default: true)
    field(:date, :date, default: now)

    belongs_to(:user, Backend.User)
    has_one(:sender, Backend.User)
  end
end
