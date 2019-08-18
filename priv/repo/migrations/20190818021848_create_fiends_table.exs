defmodule Backend.Repo.Migrations.CreateFiendsTable do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add(:user1, references(:users), primary_key: true)
      add(:user2, references(:users), primary_key: true)

      timestamps(updated_at: false)
    end

    create(index(:friends, [:user1]))
    create(index(:friends, [:user2]))
  end
end
