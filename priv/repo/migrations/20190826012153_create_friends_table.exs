defmodule Backend.Repo.Migrations.CreateFriendsTable do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add(:user_id, references(:users))
      add(:friend_id, references(:users))
    end

    create(unique_index(:friends, [:user_id, :friend_id]))
  end
end
