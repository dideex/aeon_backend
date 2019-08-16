defmodule Backend.User.Post do
  use Ecto.Schema
  require Ecto.Query


  schema "posts" do
    field(:title, :string)
    field(:body, :string)
    field(:views, :integer, default: 0)
    timestamps()

    belongs_to(:user, Backend.User)
    has_many(:likes, Backend.User)
  end
end
