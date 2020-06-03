defmodule Backend.Notification do
  alias Backend.Repo.User.Notification, as: Schema
  alias Backend.Repo

  def create(attrs, opts \\ []) do
    %Schema{}
    |> Schema.changeset(attrs)
    |> Repo.insert(opts)
  end
end
