defmodule Backend.Repo.Migrations.CreateFiendsTable do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add(:user1, references(:users))
      add(:user2, references(:users))

      timestamps(inserted_at: :created_at)
    end
  end
end
