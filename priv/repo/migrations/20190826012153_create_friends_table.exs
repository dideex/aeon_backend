defmodule Backend.Repo.Migrations.CreateFriendsTable do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add(:user_id, references(:users))
      add(:friend_id, references(:users))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:friends, [:user_id, :friend_id]))
  end
end
