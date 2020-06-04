defmodule Backend.Notification do
  alias Backend.Repo.User.Notification, as: Schema
  alias Backend.Repo

  import Ecto.Query, only: [from: 2]

  def create(attrs, opts \\ []) do
    %Schema{}
    |> Schema.changeset(attrs)
    |> Repo.insert(opts)
  end

  def get(user_id) do
    Repo.all(from u in Schema, where: u.user_id == ^user_id)
  end
end
