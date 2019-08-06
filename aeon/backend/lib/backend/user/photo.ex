defmodule Backend.User.Photo do
  use Ecto.Schema
  require Ecto.Query

  {:ok, now} = DateTime.now("Etc/UTC")

  schema "photo" do
    field :title, :string
    field :url, :string
    field :date, :date, default: now

    belongs_to :user, Backend.User
  end
end
