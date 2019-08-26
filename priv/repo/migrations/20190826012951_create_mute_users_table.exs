defmodule Backend.Repo.Migrations.CreateMuteUsersTable do
  use Ecto.Migration

  def change do
    create table(:mute_users) do
      add(:user_id, references(:users))
      add(:mute_user_id, references(:users))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:mute_users, [:user_id, :mute_user_id]))
  end
end
